ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.CheckTime)

		local xPlayer = ESX.GetPlayerData()

		if not (xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "taxi" or xPlayer.job.name == "mechanic") then -- add here more job's if needed	
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
				Ped = GetPlayerPed(-1)
				vehicle = GetVehiclePedIsIn(Ped, false)

				if Ped and vehicle then
					if GetPedInVehicleSeat(vehicle, -1) == Ped then
						if(getVehicle(Ped, vehicle)) then
							Citizen.Wait(Config.CheckTime)
						end
					end
				end
			end
		end
	end
end)

function getVehicleBlacklist(model)
	for _, blacklistedVehicle in pairs(Config.carsblacklisted) do
		if model == GetHashKey(blacklistedVehicle) then
			return true
		end
	end

	return false
end

function getVehicle(Ped, vehicle)
	if vehicle then
		vehicleModel = GetEntityModel(vehicle)
		vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)

		if getVehicleBlacklist(vehicleModel) then
			TaskLeaveVehicle(Ped, vehicle, 1)
			
			if Config.pNotify then
				TriggerEvent("pNotify:SendNotification", {
					text = Config.NotifyMessage,
					type = "error",
					timeout = 5000,
					layout = "bottomCenter"
				})
			elseif Config.EsxNotify then
				ESX.ShowNotification(Config.NotifyMessage)
			end

			return true
		end
	end
	return false
end