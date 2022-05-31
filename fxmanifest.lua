fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts { 
    '@es_extended/imports.lua',
    'locales/*.lua',
    'config/config.lua',
}

client_script 'client/main.lua'

server_script 'server/main.lua'

dependency 'es_extended'