local config = ApocalypseWorld.Config
local playerProfiles = {}
local activeWrecks = {}
local savedTransforms = {}
local noDemandSince = {}
local createFailures = {}
local wreckDefinitions = {}
local groundRejected = {}

local function getProfile(name)
    return config.profiles[name] or config.profiles[config.defaultProfile]
end

local function entityKey(gridId, entry, index)
    return ('%s:%s'):format(gridId, entry.id or index)
end

local function distance2DToBounds(coords, bounds)
    local dx = math.max(bounds.minX - coords.x, 0.0, coords.x - bounds.maxX)
    local dy = math.max(bounds.minY - coords.y, 0.0, coords.y - bounds.maxY)
    return math.sqrt(dx * dx + dy * dy)
end

local function distanceSquared2D(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    return dx * dx + dy * dy
end

local function isFinite(value)
    return type(value) == 'number' and value == value and value > -math.huge and value < math.huge
end

local function isValidTransform(grid, entry, coords, rotation)
    if not grid or not grid.bounds or not entry or not entry.coords then
        return false
    end

    if not isFinite(coords.x) or not isFinite(coords.y) or not isFinite(coords.z)
        or not isFinite(rotation.x) or not isFinite(rotation.y) or not isFinite(rotation.z) then
        return false
    end

    local bounds = grid.bounds
    local margin = config.maxWreckDisplacement
    if coords.x < bounds.minX - margin or coords.x > bounds.maxX + margin
        or coords.y < bounds.minY - margin or coords.y > bounds.maxY + margin then
        return false
    end

    if distanceSquared2D(coords, entry.coords) > margin * margin then
        return false
    end

    return math.abs(coords.z - entry.coords.z) <= config.maxVerticalDisplacement
end

local function readPlayerPosition(source)
    local ped = GetPlayerPed(source)
    if ped == 0 then
        return nil
    end

    return GetEntityCoords(ped)
end

local function saveTransform(key, entity)
    if entity == 0 or not DoesEntityExist(entity) then
        return
    end

    if Entity(entity).state.apocalypseGroundResolved ~= true then return end
    local coords = GetEntityCoords(entity)
    local rotation = GetEntityRotation(entity)
    local definition = wreckDefinitions[key]
    if not definition or not isValidTransform(definition.grid, definition.entry, coords, rotation) then
        return
    end

    local offset = Entity(entity).state.apocalypseGroundOffset
    if not isFinite(offset) or math.abs(offset) > 4.0 then offset = 0.0 end
    savedTransforms[key] = {
        coords = vector3(coords.x, coords.y, coords.z),
        rotation = vector3(rotation.x, rotation.y, rotation.z),
        groundZ = coords.z - offset
    }
end

local function createWreck(gridId, entry, index)
    local key = entityKey(gridId, entry, index)
    if groundRejected[key] then return nil end
    local existing = activeWrecks[key]
    if existing and DoesEntityExist(existing) then
        return existing
    end

    local failedAt = createFailures[key]
    if failedAt and GetGameTimer() - failedAt < config.createFailureCooldown then
        return nil
    end

    local grid = ApocalypseWorld.Grids[gridId]
    wreckDefinitions[key] = { grid = grid, entry = entry }
    local transform = savedTransforms[key]
    if transform and not isValidTransform(grid, entry, transform.coords, transform.rotation) then
        savedTransforms[key] = nil
        transform = nil
    end
    local coords = transform and transform.coords or entry.coords
    local rotation = transform and transform.rotation or entry.rotation or vector3(0.0, 0.0, entry.heading or 0.0)
    local model = ApocalypseWorld.ResolveModel(entry.model)
    if not model or model == 0 then
        createFailures[key] = GetGameTimer()
        return nil
    end
    local entity = CreateObjectNoOffset(model, coords.x, coords.y, coords.z, true, true, false)

    if entity == 0 then
        createFailures[key] = GetGameTimer()
        print(('[apocalypse-world-core] Failed to create wreck %s (%s)'):format(key, tostring(entry.model)))
        return nil
    end

    createFailures[key] = nil

    SetEntityRotation(entity, rotation.x, rotation.y, rotation.z, 2, true)
    FreezeEntityPosition(entity, entry.snapToGround == true)
    SetEntityOrphanMode(entity, 2)

    local state = Entity(entity).state
    state:set('apocalypseGrid', gridId, true)
    state:set('apocalypsePlacement', entry.id or tostring(index), true)
    state:set('apocalypseHeading', rotation.z, true)
    state:set('apocalypseSnapToGround', entry.snapToGround == true, true)
    state:set('apocalypseGroundCoords', { x = coords.x, y = coords.y, z = transform and transform.groundZ or coords.z }, true)
    state:set('apocalypseGroundResolved', entry.snapToGround ~= true, true)
    state:set('apocalypseWreck', true, true)

    activeWrecks[key] = entity
    return entity
end

local function removeWreck(key)
    local entity = activeWrecks[key]
    if not entity then
        return
    end

    saveTransform(key, entity)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
    activeWrecks[key] = nil
end

local function collectDemand()
    local demand = {}
    local sharedCap = config.maxGlobalWrecks

    for _, sourceText in ipairs(GetPlayers()) do
        local source = tonumber(sourceText)
        local coords = readPlayerPosition(source)
        local profile = getProfile(playerProfiles[source])

        if coords then
            sharedCap = math.min(sharedCap, profile.wreckCap)
            local candidates = {}
            for gridId, grid in pairs(ApocalypseWorld.Grids) do
                local bounds = grid.bounds
                if bounds and distance2DToBounds(coords, bounds) <= profile.streamRadius then
                    for index, entry in ipairs(grid.wrecks or {}) do
                        local isApproved = entry.approved == true and entry.reviewOnly ~= true and entry.enabled ~= false
                        if isApproved then
                            candidates[#candidates + 1] = {
                                key = entityKey(gridId, entry, index),
                                gridId = gridId,
                                entry = entry,
                                index = index,
                                distance = distanceSquared2D(coords, entry.coords)
                            }
                        end
                    end
                end
            end

            table.sort(candidates, function(a, b)
                return a.distance < b.distance
            end)

            local cap = math.min(profile.wreckCap, #candidates)
            for candidateIndex = 1, cap do
                local candidate = candidates[candidateIndex]
                local existing = demand[candidate.key]
                if not existing or candidate.distance < existing.distance then
                    demand[candidate.key] = candidate
                end
            end
        end
    end

    return demand, sharedCap
end

local function reconcile()
    local demand, sharedCap = collectDemand()
    local ordered = {}

    for key, item in pairs(demand) do
        item.key = key
        ordered[#ordered + 1] = item
    end

    table.sort(ordered, function(a, b)
        return a.distance < b.distance
    end)

    local keep = {}
    local limit = math.min(config.maxGlobalWrecks, sharedCap, #ordered)
    for index = 1, limit do
        local item = ordered[index]
        keep[item.key] = true
        noDemandSince[item.key] = nil
        createWreck(item.gridId, item.entry, item.index)
    end

    local now = GetGameTimer()
    for key in pairs(activeWrecks) do
        if not keep[key] then
            noDemandSince[key] = noDemandSince[key] or now
            if now - noDemandSince[key] >= config.unloadDelay then
                removeWreck(key)
                noDemandSince[key] = nil
            end
        end
    end
end

RegisterNetEvent('apocalypse-world-core:server:setProfile', function(name)
    if config.profiles[name] then
        playerProfiles[source] = name
        TriggerClientEvent('apocalypse-world-core:client:profile', source, name)
    end
end)

AddEventHandler('playerDropped', function()
    playerProfiles[source] = nil
end)

RegisterNetEvent('apocalypse-world-core:server:groundRejected', function(netId)
    if type(netId) ~= 'number' then return end
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity == 0 or not DoesEntityExist(entity) or NetworkGetEntityOwner(entity) ~= source then return end
    local coords = readPlayerPosition(source)
    if not coords then return end
    for key, wreck in pairs(activeWrecks) do
        if wreck == entity then
            local definition = wreckDefinitions[key]
            if not definition or Entity(entity).state.apocalypseGroundResolved then return end
            if distanceSquared2D(coords, definition.entry.coords) > config.groundCheckDistance ^ 2 then return end
            groundRejected[key] = true
            savedTransforms[key] = nil
            removeWreck(key)
            print(('[apocalypse-world-core] Withheld %s until restart: ground validation failed.'):format(key))
            return
        end
    end
end)

CreateThread(function()
    while true do
        reconcile()
        Wait(config.serverReconcileInterval)
    end
end)

CreateThread(function()
    while true do
        for key, entity in pairs(activeWrecks) do
            saveTransform(key, entity)
        end
        Wait(config.transformSaveInterval)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    for key in pairs(activeWrecks) do
        removeWreck(key)
    end
end)

