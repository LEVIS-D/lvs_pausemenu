local QBCore = exports['qb-core']:GetCoreObject()
local open = false
local gift = false
local function CloseUI()
    display = false
    SetNuiFocus(false, false)
    Wait(600)
    open = false 
end

RegisterKeyMapping('pausemenu', LVS.Lang['pausemenu'], 'keyboard', LVS.OpenKey)

Citizen.CreateThread(function()
	while true do
	    Wait(1)
		SetPauseMenuActive(false)
	end
end)

RegisterCommand('pausemenu', function()
    if not open and not IsPauseMenuActive() then
        open = true
        local pos = GetEntityCoords(PlayerPedId())
        local street1, street2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        QBCore.Functions.TriggerCallback('lvs_pausemenu:server:info', function(name, gender, cash, bank, jobLabel, jobGrade)
            display = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = "open",
                status = true,
                name = name,
                gender = gender,
                cash = cash,
                bank = bank,
                jobLabel = jobLabel,
                jobGrade = jobGrade,
                time = 	GetClockHours()..'.'..GetClockMinutes(),
                street = GetStreetNameFromHashKey(street1), GetStreetNameFromHashKey(street2)
            })
        end)
    end
end)

RegisterNUICallback("action", function(data)
    if data.action == 'gift' then
        CloseUI()
        if not gift then
            gift = true
            TriggerEvent("QBCore:Notify", LVS.Lang['gift'], 'success', 5000)
            TriggerServerEvent('lvs_pausemenu:server:gift')
        else
            TriggerEvent("QBCore:Notify", LVS.Lang['already'], 'error', 5000)
        end
    elseif data.action == 'settings' then
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1)
        CloseUI()
    elseif data.action == 'map' then
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),0,-1) 
        CloseUI()
    elseif data.action == 'quit' then
        CloseUI()
        TriggerServerEvent('lvs_pausemenu:server:quit')
    elseif data.action == 'close' then
        CloseUI()
    end
end)

-- THIS SCRIPT IS MADE BY LEVIS DEVELOPMENTS
-- FOR TECHNICAL SUPPORT; https://discord.gg/MVp2DHKr65, ! Onur#0443