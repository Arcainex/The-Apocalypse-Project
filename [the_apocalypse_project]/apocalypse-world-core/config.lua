ApocalypseWorld = ApocalypseWorld or {}
ApocalypseWorld.Grids = ApocalypseWorld.Grids or {}

ApocalypseWorld.Config = {
    gridSize = 100.0,
    defaultProfile = 'balanced',
    profileKvp = 'apocalypse_world_profile',
    updateInterval = 3000,
    serverReconcileInterval = 4000,
    unloadDelay = 15000,
    maxGlobalWrecks = 64,
    clutterCap = 36,
    transformSaveInterval = 5000,
    createFailureCooldown = 30000,
    maxWreckDisplacement = 35.0,
    maxVerticalDisplacement = 8.0,
    groundSnapMaxAttempts = 12,
    groundSnapRetryInterval = 1000,
    groundCheckDistance = 120.0,
    groundHeightTolerance = 1.5,
    groundMinNormalZ = 0.90,
    debug = false,

    profiles = {
        low = {
            label = 'Low',
            streamRadius = 325.0,
            wreckCap = 10,
            physicsDistance = 45.0,
            lodDistance = 120,
            clutter = false
        },
        balanced = {
            label = 'Balanced',
            streamRadius = 500.0,
            wreckCap = 24,
            physicsDistance = 75.0,
            lodDistance = 180,
            clutter = true
        },
        high = {
            label = 'High',
            streamRadius = 700.0,
            wreckCap = 40,
            physicsDistance = 110.0,
            lodDistance = 260,
            clutter = true
        }
    }
}

function ApocalypseWorld.GridId(x, y)
    local size = ApocalypseWorld.Config.gridSize
    return ('g_x%d_y%d'):format(math.floor(x / size), math.floor(y / size))
end

function ApocalypseWorld.ResolveModel(model)
    if type(model) == 'number' then
        return model
    end

    return joaat(model)
end

