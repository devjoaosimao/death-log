Citizen.CreateThread(function()
	while true do
			Citizen.Wait(6000)
			local ped = PlayerPedId()

			if IsEntityDead(ped) then
					Citizen.Wait(500)

					local pedKiller = GetPedSourceOfDeath(ped)
					local deathCauseHash = GetPedCauseOfDeath(ped)
					local weapon = WeaponNames[tostring(deathCauseHash)]
					local killer, deathReason

					if IsEntityAPed(pedKiller) then
							if IsPedAPlayer(pedKiller) then
									killer = NetworkGetPlayerIndexFromPed(pedKiller)
							end
					elseif IsEntityAVehicle(pedKiller) then
							local driver = GetPedInVehicleSeat(pedKiller, -1)
							if IsEntityAPed(driver) and IsPedAPlayer(driver) then
									killer = NetworkGetPlayerIndexFromPed(driver)
							end
					end

					if killer == PlayerId() then
							deathReason = 'se matou'
					elseif killer == nil then
							deathReason = 'morreu por razões desconhecidas'
					else
							deathReason = 'foi morto(a) por'
					end

					local playerName = GetPlayerName(PlayerId())
					local killerName = killer and GetPlayerName(killer) or "Algo ou alguém"
					local msg

					if deathReason == 'se matou' or deathReason == 'morreu por razões desconhecidas' then
							msg = string.format("***%s*** %s.", playerName, deathReason)
					else
							msg = string.format("***%s*** %s ***%s***.", killerName, deathReason, playerName)
					end

					if weapon then
							msg = msg .. string.format(" Usando %s.", weapon)
					end

					TriggerServerEvent('DiscordBot:playerDied', msg, weapon)

					killer, deathReason, deathCauseHash, weapon = nil, nil, nil, ''

					repeat Citizen.Wait(0) until not IsEntityDead(PlayerPedId())
			end
	end
end)


local show3DText = true -- if true it will show combatlog default

RegisterNetEvent("remd-combat-log:show")
AddEventHandler("remd-combat-log:show", function()
	if show3DText then
		show3DText = false
	else
		show3DText = true
		if Config.AutoDisableDrawing then
			if tonumber(Config.AutoDisableDrawing) then
				Citizen.Wait(Config.AutoDisableDrawingTime)
			else
				Citizen.Wait(15000)
			end
			show3DText = false
		end
	end
end)

RegisterNetEvent("remd-combat-log")
AddEventHandler("remd-combat-log", function(id, crds, identifier, reason, name)
	Display(id, crds, identifier, reason, name)
end)

function Display(id, crds, identifier, reason, name)
	local displaying = true

	Citizen.CreateThread(function()
		Wait(Config.DrawingTime)
		displaying = false
	end)

	Citizen.CreateThread(function()
		while displaying do
			Wait(5)
			local pcoords = GetEntityCoords(PlayerPedId())
			if show3DText and #(crds - pcoords) < 15.0 then
				drawText3d(crds.x, crds.y, crds.z + Config.NameorLabel, name, Config.AlertTextColor)
				drawText3d(crds.x, crds.y, crds.z, "ID: " .. id .. " (" .. identifier .. ")\nReason: " .. reason, Config.TextColor)
			else
				Citizen.Wait(2000)
			end
		end
	end)
end

function drawText3d(x, y, z, text, color)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFontForCurrentCommand(1)
		SetTextColor(color.r, color.g, color.b, 255)
		SetTextCentre(1)
		DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
	end
end

AddEventHandler('onResourceStart', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end
end)