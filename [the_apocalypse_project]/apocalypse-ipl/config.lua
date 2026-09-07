ApocalypseIpl = {
    -- Set false only when another resource deliberately owns these IPLs.
    -- The map can then be less stable around configured vanilla interiors.
    enabled = true,
    pollIntervalMs = 1000,
    debug = false,
    zones = {
        arena_real = {
            center = vector3(-257.98, -2024.03, 29.15),
            radius = 175.0,
            ipls = { 'sp1_10_real_interior' },
            removeIpls = { 'sp1_10_fake_interior' },
            interiorPoints = {
                vector3(-257.98, -2024.03, 29.15),
            },
        },
        metro_del_perro = {
            center = vector3(-828.0, -117.0, 23.0),
            radius = 175.0,
            -- Add only IPL names verified against the map import and game build.
            ipls = {},
            interiorPoints = {
                vector3(-828.0, -117.0, 27.0),
                vector3(-805.0, -135.0, 19.0),
            },
        },
    },
}

