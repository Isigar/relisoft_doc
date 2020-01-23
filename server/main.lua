ESX = nil
Tasks = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand','doc',function(source, args, user)
    if args[1] == nil then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1Chyba', 'Prosim pouzijte /doc 1-20!' } })
    else
        local number = tonumber(args[1])
        if number > 20 or number < 1 then
            TriggerClientEvent('chat:addMessage', source, { args = { '^1Chyba', 'Prosim pouzijte /doc 1-20!' } })
        else
            if Tasks[source] == nil then
                Tasks[source] = {}
            end
            Tasks[source] = {times = number, current = 0, source = source}
        end
    end
end, {})

local function startChatTimer()
    SetTimeout(1000,function()
        for k,v in pairs(Tasks) do
            v.current = v.current + 1
            Tasks[k] = v
            TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, v.source, _U('do_prefix', GetCharacterName(v.source)), tostring(v.current).." / "..tostring(v.times), { 164, 66, 244 })
            if v.current == v.times then
                Tasks[k] = nil
            end
        end
        startChatTimer()
    end)
end
startChatTimer()

function GetCharacterName(source)
    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = GetPlayerIdentifiers(source)[1]
    })

    if result[1] and result[1].firstname and result[1].lastname then
        if Config.OnlyFirstname then
            return result[1].firstname
        else
            return ('%s %s'):format(result[1].firstname, result[1].lastname)
        end
    else
        return GetPlayerName(source)
    end
end
