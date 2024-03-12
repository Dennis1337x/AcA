function isPlayerFlyByHack(thePlayer, type)
  
	if type == "player" then
		disMax = config.flyPlayer[2]
	elseif type == "vehicle" then
		disMax = config.flyVehicle[2]
	end
	if (tonumber(getElementData(thePlayer, "admin_level") or 0) <= 0 and tonumber(getElementData(thePlayer, "supporter_level") or 0) <= 0) then 
		local px, py, pz = getElementPosition(thePlayer)
		local groundHeight = getGroundPosition(px, py, pz)
		local playerHeightAboveGround = pz - groundHeight
		if playerHeightAboveGround > disMax then
			return true
		end
		return false
	end
end

function math.round(num, decimals)
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end



function antiCheatRender()
  
	local player = getLocalPlayer()
	local vehicle = getPedOccupiedVehicle(player)
	local gameSpeed = getGameSpeed()
	if config.JetPack and isPedWearingJetpack(localPlayer) then
		triggerServerEvent('AntiCheat:Protected:Send',localPlayer,localPlayer,"JetPack-Hack")
	end	
	if config.aircars and isWorldSpecialPropertyEnabled("aircars") then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"aircars-hack")
	end
	if config.hovercars and isWorldSpecialPropertyEnabled("hovercars") then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"hovercars-hack")
	end
	if config.extrabunny and isWorldSpecialPropertyEnabled("extrabunny") then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"extrabunny-hack")
	end
	if config.extrajump and isWorldSpecialPropertyEnabled("extrajump") then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"extrajump-hack")
	end
	if config.pedFire and isPedOnFire(localPlayer) then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"pedfire-hack")
	end
	if config.invisible and (tonumber(getElementData(player, "admin_level") or 0) <= 0 and tonumber(getElementData(player, "supporter_level") or 0) <= 0) and getElementAlpha(player) < 255 then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"invisible-hack")
	end
	if config.invisibleCar and vehicle and (tonumber(getElementData(player, "admin_level") or 0) < 1 or tonumber(getElementData(player, "supporter_level") or 0) < 1) and getElementAlpha(vehicle) < 255 then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"invisibleCar-hack")
	end
	if config.speedGame[1] and gameSpeed > config.speedGame[2] then 
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"speedGame-hack")
	end
	if config.speedVehicle[1] and vehicle then
		local vx, vy, vz = getElementVelocity (vehicle)
		km = math.sqrt(vx^2 + vy^2 + vz^2) * 165
		if km >= config.speedVehicle[2] then
			triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"speedVehicle-hack")
		end
	end
	if config.flyPlayer[1] and not vehicle and isPlayerFlyByHack(player, "player") then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"flyPlayer-hack")
	end
	if config.flyVehicle[1] and vehicle and isPlayerFlyByHack(player, "vehicle") then
		triggerServerEvent('AntiCheat:Protected:Send', localPlayer, localPlayer,"flyVehicle-hack")
	end
end
addEventHandler("onClientRender", root, antiCheatRender)





function antiExplostion(_,_,_,type)

    if type == 4 or type == 5 or type == 6 or type == 7 then
        return cancelEvent()
    end
    if isElement(source) and getElementType(source) == "player" then
        table.foreach(config.explosion["explosion-ids"], function(index,value)
            if type == value then
                triggerServerEvent('AntiCheat:Protected:Send',source,source,"Explosion-Hack")
                cancelEvent()
                return;
            end
        end)
    end
end
addEventHandler('onClientExplosion',getRootElement(), antiExplostion)


