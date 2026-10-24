fx_version 'cerulean'
game 'gta5'

author 'The Apocalypse Project'
description 'Deterministic world dressing and movable wreck management'
version '1.0.0'

lua54 'yes'
this_is_a_map 'yes'

shared_scripts {
    'config.lua',
    'grids/**/grid.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

dependency '/onesync'

