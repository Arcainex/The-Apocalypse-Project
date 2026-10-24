local config = ApocalypseWorld.Config
local profileName = config.defaultProfile
local localClutter = {}
local knownWrecks = {}
local managedWrecks = {}
local pendingGroundSnap = {}
local pendingStateBags = {}
local clutterRetryAt = {}
local rejectedWrecks = 0

local function notify(message)
    TriggerEvent('chat:addMessage', {
        color = { 196, 126, 52 },
        args = { 'World', message }
    })
end

local function getProfile(name)
    return config.profiles[name] or config.profiles[config.defaultProfile]
end

local function setProfile(name, quiet)
    if not config.profiles[name] then
        return false
    end

    profileName = name
    SetResourceKvp(config.profileKvp, name)
    TriggerServerEvent('apocalypse-world-core:server:setProfile', name)

    if not quiet then
        notify(('Performance profile set to %s.'):format(config.profiles[name].label))
    end

    return true
end

local function distanceSquared(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    local dz = a.z - b.z
    return dx * dx + dy * dy + dz * dz
end

local function deleteLocalClutter(key)
    local entity = localClutter[key]
    if entity and DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
    localClutter[key] = nil
end

local function findRoadSurface(coords, ignoreEntity)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    local probe = StartShapeTestLosProbe(coords.x, coords.y, coords.z + 1.25,
        coords.x, coords.y, coords.z - 2.0, 1, ignoreEntity or 0, 7)
    local timeout = GetGameTimer() + 500
    local result, hit, point, normal
    repeat
        result, hit, point, normal = GetShapeTestResult(probe)
        if result == 1 then Wait(0) end
    until result ~= 1 or GetGameTimer() >= timeout

    if result ~= 2 or not hit or normal.z < config.groundMinNormalZ
        or math.abs(point.z - coords.z) > config.groundHeightTolerance then
        return nil
    end
    return point, normal
end

local function settleOnSurface(entity, point, normal, heading, authoredRotation)
    local angle = math.rad(heading)
    local forward = -normal.x * math.sin(angle) + normal.y * math.cos(angle)
    local right = normal.x * math.cos(angle) + normal.y * math.sin(angle)
    local pitch = math.deg(math.atan(-forward, normal.z))
    local roll = math.deg(math.atan(right, math.sqrt(forward * forward + normal.z * normal.z)))
    SetEntityRotation(entity, pitch + (authoredRotation and authoredRotation.x or 0.0),
        roll + (authoredRotation and authoredRotation.y or 0.0), heading, 2, true)
    local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
    local origin = GetEntityCoords(entity)
    local lowest = math.huge
    for _, x in ipairs({ minimum.x, maximum.x }) do
        for _, y in ipairs({ minimum.y, maximum.y }) do
            for _, z in ipairs({ minimum.z, maximum.z }) do
                local corner = GetOffsetFromEntityInWorldCoords(entity, x, y, z)
                local projection = (corner.x - origin.x) * normal.x
                    + (corner.y - origin.y) * normal.y + (corner.z - origin.z) * normal.z
                lowest = math.min(lowest, projection)
            end
        end
    end
    local offset = -lowest + 0.02
    SetEntityCoordsNoOffset(entity, point.x + normal.x * offset,
        point.y + normal.y * offset, point.z + normal.z * offset, false, false, false)
    return normal.z * offset
end

local function spawnLocalClutter(key, entry)
    if localClutter[key] and DoesEntityExist(localClutter[key]) then
        return
    end

    if clutterRetryAt[key] and GetGameTimer() < clutterRetryAt[key] then return end
    if distanceSquared(GetEntityCoords(PlayerPedId()), entry.coords) > config.groundCheckDistance ^ 2 then return end
    local point, normal = findRoadSurface(entry.coords)
    if not point then
        clutterRetryAt[key] = GetGameTimer() + config.createFailureCooldown
        return
    end

    local model = ApocalypseWorld.ResolveModel(entry.model)
    if not IsModelInCdimage(model) or not IsModelValid(model) then
        return
    end

    RequestModel(model)
    local timeout = GetGameTimer() + 4000
    while not HasModelLoaded(model) and GetGameTimer() < timeout do
        Wait(0)
    end

    if not HasModelLoaded(model) then
        SetModelAsNoLongerNeeded(model)
        return
    end

    local coords = entry.coords
    local entity = CreateObjectNoOffset(model, coords.x, coords.y, coords.z, false, false, false)
    if entity == 0 then
        SetModelAsNoLongerNeeded(model)
        return
    end

    settleOnSurface(entity, point, normal, entry.heading or (entry.rotation and entry.rotation.z) or 0.0, entry.rotation)
    SetEntityCollision(entity, entry.collision ~= false, true)
    FreezeEntityPosition(entity, true)
    SetEntityLodDist(entity, getProfile(profileName).lodDistance)
    localClutter[key] = entity
    SetModelAsNoLongerNeeded(model)
end

local function updateClutter(playerCoords)
    local profile = getProfile(profileName)
    local keep = {}
    local candidates = {}

    if profile.clutter then
        local radiusSquared = profile.streamRadius * profile.streamRadius
        for gridId, grid in pairs(ApocalypseWorld.Grids) do
            local bounds = grid.bounds
            local nearGrid = bounds
                and playerCoords.x >= bounds.minX - profile.streamRadius
                and playerCoords.x <= bounds.maxX + profile.streamRadius
                and playerCoords.y >= bounds.minY - profile.streamRadius
                and playerCoords.y <= bounds.maxY + profile.streamRadius

            if nearGrid then
                for index, entry in ipairs(grid.clutter or {}) do
                    local isApproved = entry.approved == true and entry.reviewOnly ~= true and entry.enabled ~= false
                    local distance = isApproved and distanceSquared(playerCoords, entry.coords) or nil
                    if distance and distance <= radiusSquared then
                        candidates[#candidates + 1] = {
                            key = ('%s:%s'):format(gridId, entry.id or index),
                            entry = entry,
                            distance = distance
                        }
                    end
                end
            end
        end

        table.sort(candidates, function(a, b)
            return a.distance < b.distance
        end)

        local cap = math.min(config.clutterCap, #candidates)
        for index = 1, cap do
            local candidate = candidates[index]
            keep[candidate.key] = true
            spawnLocalClutter(candidate.key, candidate.entry)
        end
    end

    for key in pairs(localClutter) do
        if not keep[key] then
            deleteLocalClutter(key)
        end
    end
end

local function configureWreck(entity)
    if entity == 0 or not DoesEntityExist(entity) then
        return false
    end

    local netId = NetworkGetNetworkIdFromEntity(entity)
    if knownWrecks[netId] == entity then
        return true
    end

    local state = Entity(entity).state
    if state.apocalypseSnapToGround == nil or state.apocalypseGroundResolved == nil
        or (state.apocalypseSnapToGround and not state.apocalypseGroundCoords) then
        return false
    end
    knownWrecks[netId] = entity
    managedWrecks[netId] = entity
    SetEntityLodDist(entity, getProfile(profileName).lodDistance)
    SetEntityCollision(entity, true, true)
    FreezeEntityPosition(entity, not state.apocalypseGroundResolved)
    if state.apocalypseSnapToGround and not state.apocalypseGroundResolved then
        pendingGroundSnap[netId] = {
            entity = entity,
            attempts = 0,
            nextAttempt = 0,
            coords = state.apocalypseGroundCoords or GetEntityCoords(entity)
        }
    end
    return true
end

local function resolveGroundSnaps()
    local now = GetGameTimer()
    for netId, pending in pairs(pendingGroundSnap) do
        local entity = pending.entity
        if not DoesEntityExist(entity) then
            pendingGroundSnap[netId] = nil
        elseif now >= pending.nextAttempt
            and distanceSquared(GetEntityCoords(PlayerPedId()), pending.coords) <= config.groundCheckDistance ^ 2
            and NetworkHasControlOfEntity(entity) then
            local state = Entity(entity).state
            if state.apocalypseGroundResolved then
                FreezeEntityPosition(entity, false)
                pendingGroundSnap[netId] = nil
            else
                FreezeEntityPosition(entity, true)
                local point, normal = findRoadSurface(pending.coords, entity)
                if not DoesEntityExist(entity) or not NetworkHasControlOfEntity(entity) then
                    goto continue
                end
                if point then
                    local offset = settleOnSurface(entity, point, normal, state.apocalypseHeading or GetEntityHeading(entity))
                    state:set('apocalypseGroundOffset', offset, true)
                    state:set('apocalypseGroundResolved', true, true)
                    FreezeEntityPosition(entity, false)
                    SetEntityDynamic(entity, true)
                    ActivatePhysics(entity)
                    pendingGroundSnap[netId] = nil
                    goto continue
                end
                pending.attempts = pending.attempts + 1
                pending.nextAttempt = now + config.groundSnapRetryInterval
                if pending.attempts >= config.groundSnapMaxAttempts then
                    TriggerServerEvent('apocalypse-world-core:server:groundRejected', netId)
                    pendingGroundSnap[netId] = nil
                    rejectedWrecks = rejectedWrecks + 1
                    print(('[apocalypse-world-core] Withheld wreck %d: no valid nearby road surface.'):format(netId))
                end
            end
        elseif distanceSquared(GetEntityCoords(PlayerPedId()), pending.coords) <= config.groundCheckDistance ^ 2 then
            NetworkRequestControlOfEntity(entity)
        end
        ::continue::
    end
end

local function updateWreckPhysics(playerCoords)
    local profile = getProfile(profileName)
    local physicsDistanceSquared = profile.physicsDistance * profile.physicsDistance

    for netId, entity in pairs(managedWrecks) do
        if not DoesEntityExist(entity) then
            managedWrecks[netId] = nil
            knownWrecks[netId] = nil
        else
            local isNear = distanceSquared(playerCoords, GetEntityCoords(entity)) <= physicsDistanceSquared
            SetEntityLodDist(entity, profile.lodDistance)
            if isNear and Entity(entity).state.apocalypseGroundResolved then
                if NetworkHasControlOfEntity(entity) then
                    SetEntityDynamic(entity, true)
                    ActivatePhysics(entity)
                else
                    NetworkRequestControlOfEntity(entity)
                end
            end
        end
    end
end

RegisterNetEvent('apocalypse-world-core:client:profile', function(name)
    if config.profiles[name] then
        profileName = name
    end
end)

AddStateBagChangeHandler('apocalypseWreck', nil, function(bagName, _, value)
    if not value then
        return
    end

    local entity = GetEntityFromStateBagName(bagName)
    if entity == 0 or not configureWreck(entity) then
        pendingStateBags[bagName] = {
            attempts = 0,
            nextAttempt = GetGameTimer()
        }
    end
end)

RegisterCommand('worldprofile', function(_, args)
    local requested = args[1] and string.lower(args[1]) or nil
    if requested and setProfile(requested, false) then
        return
    end

    notify(('Usage: /worldprofile low|balanced|high (current: %s)'):format(profileName))
end, false)

RegisterCommand('worldstatus', function()
    local clutterCount = 0
    for _ in pairs(localClutter) do
        clutterCount = clutterCount + 1
    end

    local wreckCount, pendingCount = 0, 0
    for _, entity in pairs(managedWrecks) do
        if DoesEntityExist(entity) then wreckCount = wreckCount + 1 end
    end
    for _ in pairs(pendingGroundSnap) do pendingCount = pendingCount + 1 end
    notify(('Profile: %s | wrecks: %d | clutter: %d | grounding: %d | withheld: %d')
        :format(profileName, wreckCount, clutterCount, pendingCount, rejectedWrecks))
end, false)

CreateThread(function()
    local saved = GetResourceKvpString(config.profileKvp)
    setProfile(config.profiles[saved] and saved or config.defaultProfile, true)

    while true do
        local ped = PlayerPedId()
        if ped ~= 0 then
            local coords = GetEntityCoords(ped)
            updateClutter(coords)
            updateWreckPhysics(coords)
        end
        Wait(config.updateInterval)
    end
end)

CreateThread(function()
    Wait(5000)
    local objects = GetGamePool('CObject')
    for index = 1, #objects do
        local entity = objects[index]
        local state = Entity(entity).state
        if state and state.apocalypseWreck then
            if not configureWreck(entity) then
                pendingStateBags[('entity:%d'):format(NetworkGetNetworkIdFromEntity(entity))] = {
                    attempts = 0,
                    nextAttempt = GetGameTimer()
                }
            end
        end
    end

    while true do
        local now = GetGameTimer()
        resolveGroundSnaps()
        for bagName, pending in pairs(pendingStateBags) do
            if now >= pending.nextAttempt then
                local entity = GetEntityFromStateBagName(bagName)
                if entity ~= 0 and configureWreck(entity) then
                    pendingStateBags[bagName] = nil
                else
                    pending.attempts = pending.attempts + 1
                    pending.nextAttempt = now + 500
                    if pending.attempts >= 20 then
                        pendingStateBags[bagName] = nil
                    end
                end
            end
        end
        Wait(250)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    for key in pairs(localClutter) do
        deleteLocalClutter(key)
    end
end)

