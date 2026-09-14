local loadedZones = {}
local loadedGlobals = {}

local function log(message)
    if ApocalypseIpl.debug then
        print(('[apocalypse-ipl] %s'):format(message))
    end
end

local function activateZone(name, zone)
    if not ApocalypseIpl.enabled then return end
    if zone.enabled == false then return end
    if loadedZones[name] then return end

    for _, ipl in ipairs(zone.removeIpls or {}) do
        if IsIplActive(ipl) then
            RemoveIpl(ipl)
        end
    end
    for _, ipl in ipairs(zone.ipls) do
        if not IsIplActive(ipl) then
            RequestIpl(ipl)
        end
    end

    local foundInterior = false
    for _, point in ipairs(zone.interiorPoints) do
        local interior = GetInteriorAtCoords(point.x, point.y, point.z)
        if interior ~= 0 then
            foundInterior = true
            PinInteriorInMemory(interior)
            LoadInterior(interior)
            if zone.forceInteriorActive then
                SetInteriorActive(interior, true)
            end
            RefreshInterior(interior)
        end
    end

    loadedZones[name] = true
    log(('activated %s; interior found: %s'):format(name, foundInterior))
end


local function activateGlobal(name, group)
    if group.enabled == false or loadedGlobals[name] then return end

    for _, ipl in ipairs(group.removeIpls or {}) do
        if IsIplActive(ipl) then
            RemoveIpl(ipl)
        end
    end
    for _, ipl in ipairs(group.ipls or {}) do
        if not IsIplActive(ipl) then
            RequestIpl(ipl)
        end
    end

    loadedGlobals[name] = true
    log(('activated global IPL group %s'):format(name))
end
CreateThread(function()
    if ApocalypseIpl.enabled then
        for name, group in pairs(ApocalypseIpl.globals or {}) do
            activateGlobal(name, group)
        end
    end
    while true do
        if ApocalypseIpl.enabled then
            local playerCoords = GetEntityCoords(PlayerPedId())
            for name, zone in pairs(ApocalypseIpl.zones) do
                if not loadedZones[name] and #(playerCoords - zone.center) <= zone.radius then
                    activateZone(name, zone)
                end
            end
        end
        Wait(ApocalypseIpl.pollIntervalMs)
    end
end)

RegisterCommand('tapiplstatus', function()
    if not ApocalypseIpl.enabled then
        print('[apocalypse-ipl] loader disabled by config; no IPLs or interiors are managed by this resource.')
        return
    end

    for name, zone in pairs(ApocalypseIpl.zones) do
        local details = {}
        for _, point in ipairs(zone.interiorPoints) do
            local interior = GetInteriorAtCoords(point.x, point.y, point.z)
            details[#details + 1] = ('%d loaded=%s'):format(interior, interior ~= 0 and IsInteriorReady(interior) or false)
        end
        print(('[apocalypse-ipl] %s active=%s interiors=[%s]'):format(name, loadedZones[name] == true, table.concat(details, ', ')))
    end
end, false)

RegisterCommand('tapmapaudit', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local candidates = {}

    for _, entity in ipairs(GetGamePool('CObject')) do
        local coords = GetEntityCoords(entity)
        local distance = #(coords - playerCoords)

        if distance <= 120.0 then
            local model = GetEntityModel(entity)
            local minimum, maximum = GetModelDimensions(model)
            local size = maximum - minimum
            local volume = math.abs(size.x * size.y * size.z)

            candidates[#candidates + 1] = {
                coords = coords,
                distance = distance,
                model = model,
                volume = volume,
                size = size,
            }
        end
    end

    table.sort(candidates, function(left, right)
        return left.volume > right.volume
    end)

    print(('[apocalypse-ipl] map audit at %.2f, %.2f, %.2f; nearby objects=%d')
        :format(playerCoords.x, playerCoords.y, playerCoords.z, #candidates))

    for index = 1, math.min(#candidates, 20) do
        local entry = candidates[index]
        print(('[apocalypse-ipl] #%d model=%u pos=%.2f,%.2f,%.2f size=%.1f,%.1f,%.1f distance=%.1f')
            :format(index, entry.model, entry.coords.x, entry.coords.y, entry.coords.z,
                entry.size.x, entry.size.y, entry.size.z, entry.distance))
    end
end, false)
exports('ActivateZone', function(name)
    if not ApocalypseIpl.enabled then return false end
    local zone = ApocalypseIpl.zones[name]
    if not zone then return false end
    activateZone(name, zone)
    return true
end)