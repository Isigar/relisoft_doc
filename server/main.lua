local Tasks = {}

RegisterCommand('doc', function(source, args, user)
    if args[1] then
        local number = tonumber(args[1])
	if not number then
            TriggerClientEvent('chat:addMessage', source, { template = '<div style="padding: 0.25vw; margin: 0.15vw; background-color: #6b6b6b; border-radius: 5px; display:inline-block;"> {0}^0: {1}</div>', args = { _U('error'),  _U('use_number') } })
            return
        end
        if Tasks[source] then
            TriggerClientEvent('chat:addMessage', source, { template = '<div style="padding: 0.25vw; margin: 0.15vw; background-color: #6b6b6b; border-radius: 5px; display:inline-block;"> {0}^0: {1}</div>', args = { _U('error'), _U('multiple') } })
            return
        end
        if number > Config.MaximumNumber or number < 1 then
            TriggerClientEvent('chat:addMessage', source, { template = '<div style="padding: 0.25vw; margin: 0.15vw; background-color: #6b6b6b; border-radius: 5px; display:inline-block;"> {0}^0: {1}</div>', args = { _U('error'),  _U('use_number') } })
            return
        end
        if math.floor(number) ~= number then
            TriggerClientEvent('chat:addMessage', source, { template = '<div style="padding: 0.25vw; margin: 0.15vw; background-color: #6b6b6b; border-radius: 5px; display:inline-block;"> {0}^0: {1}</div>', args = { _U('error'),  _U('use_number') } })
            return
        end
        if Tasks[source] == nil then
            Tasks[source] = {}
        end
        Tasks[source] = {times = number, current = 0, source = source}
    else
        TriggerClientEvent('chat:addMessage', source, { template = '<div style="padding: 0.25vw; margin: 0.15vw; background-color: #6b6b6b; border-radius: 5px; display:inline-block;"> {0}^0: {1}</div>', args = { _U('error'),  _U('use_number') } })
    end
end, false)

CreateThread(function()
    while true do
        Wait(1000)
        for k,v in pairs(Tasks) do
            Tasks[k].current += 1
            TriggerClientEvent('relisoft_doc:sendDoc', -1, v.source, _U('doc_prefix', GetCharacterName(v.source)), tostring(v.current).."/"..tostring(v.times))
            if v.current >= v.times then
                Tasks[k] = nil
            end
        end
    end
end)

function GetCharacterName(src)
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer then
        	return xPlayer.getName()
	else
		return GetPlayerName(src)
	end
end
