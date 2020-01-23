fx_version 'adamant'
games { 'common' }

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/cs.lua',
    'config/config.lua',
    'server/main.lua'
}

dependency 'es_extended'