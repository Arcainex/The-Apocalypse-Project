-- The Apocalypse Project | Grand Senora airfield profile selector
--
-- server.cfg:
--   setr apocalypse_airfield_profile new      -- default: Post Apocalyptic Airbase
--   setr apocalypse_airfield_profile legacy   -- repaired VEST Military Base
--
-- Both profile resources live in the project folder so contributors receive
-- both assets, but this guard stops the unselected resource before it streams.

local profiles = {
    new = 'apocalypse-airfield-new',
    legacy = 'apocalypse-airfield-legacy',
}

local selected = string.lower(GetConvar('apocalypse_airfield_profile', 'new'))
if not profiles[selected] then
    selected = 'new'
end

SetConvarReplicated('apocalypse_airfield_profile', selected)

AddEventHandler('onResourceStarting', function(resourceName)
    for profile, resource in pairs(profiles) do
        if resourceName == resource and profile ~= selected then
            print(('[apocalypse-airfield] Skipping %s profile; active profile is %s.'):format(profile, selected))
            CancelEvent()
            return
        end
    end
end)

CreateThread(function()
    print(('[apocalypse-airfield] Active profile: %s (%s).'):format(selected, profiles[selected]))
end)
