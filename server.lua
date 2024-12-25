local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('lvs_pausemenu:server:info', function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)  
    if player.PlayerData.charinfo.gender == 0 then
        gender = LVS.Lang['male']
    else
        gender = LVS.Lang['female']
    end
    cb(player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname, gender, player.PlayerData.money.cash, player.PlayerData.money.bank, player.PlayerData.job.label, player.PlayerData.job.grade.name)
end)

RegisterNetEvent('lvs_pausemenu:server:quit', function()
    DropPlayer(source, LVS.Lang['quit'])
end)

RegisterNetEvent('lvs_pausemenu:server:gift', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)  
    player.Functions.AddMoney('cash', LVS.GiftCount)
end)

-- THIS SCRIPT IS MADE BY LEVIS DEVELOPMENTS
-- FOR TECHNICAL SUPPORT; https://discord.gg/MVp2DHKr65, ! Onur#0443