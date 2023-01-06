-- Set the coordinates of the safe zone
local safeZoneX =-837.0428
local safeZoneY = -221.7211
local safeZoneZ = 37.1655

-- radius of the safe zone in meters
local safeZoneRadius = 50
local retval --[[ Blip ]] =
	AddBlipForRadius(safeZoneX, safeZoneY, safeZoneZ, safeZoneRadius)
  SetBlipColour(blip, 1)
SetBlipAlpha(blip, 128)

Citizen.CreateThread(function()
    while true do
        -- check if the player is within the safe zone
        local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
        local distance = Vdist(safeZoneX, safeZoneY, safeZoneZ, playerX, playerY, playerZ)
        if distance < safeZoneRadius then
            -- player is in safe zone, do something (e.g. disable combat)
          --  SetPedCombatAbility(PlayerId(), 0)
          SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
          SetPlayerCanDoDriveBy(PlayerId(), false)
          --print("in")
        else
            -- player is not in safe zone, do something else (e.g. enable combat)
         --   SetPedCombatAbility(PlayerId(), 1)
        -- print("out")
        SetPlayerCanDoDriveBy(PlayerId(), true)
        end
        Citizen.Wait(1000)
    end
end)

