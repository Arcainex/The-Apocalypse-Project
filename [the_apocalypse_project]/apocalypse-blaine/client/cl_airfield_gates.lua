-- BeyondSurvival | Blaine military-base airport gates
-- The four airport gates are existing YMAP entities. They remain permanently
-- unlocked and open; this file does not change their placement or rotation.

local gates = {
    { doorId = `apocalypse_airfield_gate_1`, coords = vector3(1723.20, 3259.50, 40.14) },
    { doorId = `apocalypse_airfield_gate_2`, coords = vector3(1735.66, 3294.91, 40.12) },
    { doorId = `apocalypse_airfield_gate_3`, coords = vector3(1700.78, 3267.60, 40.14) },
    { doorId = `apocalypse_airfield_gate_4`, coords = vector3(1776.02, 3281.00, 40.30) },
}

local gateModel = `prop_gate_airport_01`

CreateThread(function()
    for _, gate in ipairs(gates) do
        AddDoorToSystem(gate.doorId, gateModel, gate.coords.x, gate.coords.y, gate.coords.z, false, false, false)
    end

    -- Reapply after streaming changes so the map cannot restore a closed gate.
    while true do
        for _, gate in ipairs(gates) do
            DoorSystemSetDoorState(gate.doorId, 0, false, false)
            DoorSystemSetOpenRatio(gate.doorId, 1.0, false, false)
        end
        Wait(1500)
    end
end)