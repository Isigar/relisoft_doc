RegisterNetEvent('relisoft_doc:sendDoc', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid ~= -1 then
      if pid == myId or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(pid))) < 20 then
          TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.25vw; margin: 0.15vw; background-color: #6b6b6b; border-radius: 5px; display:inline-block;"> {0}: {1}</div>',
            args = { name, message }
          })
      end
  end
end)