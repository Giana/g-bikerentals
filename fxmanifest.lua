fx_version 'cerulean'

game 'gta5'

author 'Giana'
description 'g-bikerentals'

shared_script 'config.lua'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua'
}

server_script 'server/main.lua'

dependencies {
    'qb-core',
    'qb-menu',
    'PolyZone'
}

lua54 'yes'