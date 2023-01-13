--[[ Set the coordinates of the safe zone
local safeZoneX =-837.0428
local safeZoneY = -221.7211
local safeZoneZ = 37.1655
--]]


CreateThread(function()
    Wait(500)
    for k, v in pairs(Config.zones) do
     
AddBlipForRadius(Config.zone.coords , Config.zone.Config.zone.radius )
 SetBlipColour(blip, Config.zone.Config.zone.color )
SetBlipAlpha(blip, Config.zone.transparent )

    end
end)


Citizen.CreateThread(function()
    while true do
        -- check if the player is within the safe zone
        local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
        local distance = Vdist(Config.zone.coords, playerX, playerY, playerZ)
        if distance < safeZoneRadius then
            -- player is in safe zone, do something (e.g. disable combat)
          --  SetPedCombatAbility(PlayerId(), 0)
          SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
          SetPlayerCanDoDriveBy(PlayerId(), false)
	 lib.showTextUI(Translation.Zone, {icon = "fa-solid fa-circle-exclamation"})
          --print("in")--for debug  only
        else
            -- player is not in safe zone, do something else (e.g. enable combat)
         --   SetPedCombatAbility(PlayerId(), 1)
        -- print("out") --for debug only 
        SetPlayerCanDoDriveBy(PlayerId(), true)
        end
        Citizen.Wait(1000)
    end
end)

