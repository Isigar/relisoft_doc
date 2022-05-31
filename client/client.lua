RegisterNetEvent('relisoft_doc:sendDoc', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    if pid ~= -1 then
        if pid == myId then
            TriggerEvent('chat:addMessage', {
              args = { name, message }
            })
        elseif #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(pid))) < 20 then
            TriggerEvent('chat:addMessage', {
              args = { name, message }
            })
        end
    end
end)