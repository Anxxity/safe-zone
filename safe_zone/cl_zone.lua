-- Set the coordinates of the safe zone
local safeZoneX =-837.0428
local safeZoneY = -221.7211
local safeZoneZ = 37.1655
local safeZoneRadius = 50.0

-- Create a marker at the safe zone location
local retval --[[ Blip ]] =
	AddBlipForRadius(safeZoneX, safeZoneY, safeZoneZ, safeZoneRadius)

-- Create a trigger to check if players are inside the safe zone
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    -- Get the player's position
    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

    -- Check if the player is inside the safe zone
    if Vdist2(safeZoneX, safeZoneY, safeZoneZ, playerX, playerY, playerZ) < safeZoneRadius * safeZoneRadius then
      -- The player is inside the safe zone. Disable the player's weapons.
      SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
      SetPlayerCanDoDriveBy(PlayerId(), false)
      SetPedDropsWeaponsWhenDead(GetPlayerPed(-1), true)
    else
      -- The player is outside the safe zone. Enable the player's weapons.
      SetPlayerCanDoDriveBy(PlayerId(), true)
      SetPedDropsWeaponsWhenDead(GetPlayerPed(-1), false)
    end
  end
end)
