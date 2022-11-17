ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		if Config.OldESX then
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		elseif not Config.OldESX then
			ESX = exports["es_extended"]:getSharedObject()
		end
		Citizen.Wait(10)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.CheckTime)
		while ESX == nil do
			Wait(100)
		end

		while ESX.PlayerData == nil do
			Wait(100)
		end

		local playerPed = PlayerPedId()
		
		print(getEmergencyJob())
		if not getEmergencyJob() and playerPed then
			if IsPedInAnyVehicle(playerPed) then
				vehicle = GetVehiclePedIsIn(playerPed, false)

				if vehicle then
					if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						getVehicleStatus(playerPed, vehicle)
					end
				end
			end
		end
	end
end)

function getEmergencyJob()
	if not ESX.PlayerData then
		return false
	end

	for k,v in ipairs(Config.emergencyJobs) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

function getVehicleBlacklist(model)
	for _, blacklistedVehicle in pairs(Config.emergencyVehicles) do
		if model == GetHashKey(blacklistedVehicle) then
			return true
		end
	end

	return false
end

function getVehicleStatus(Ped, vehicle)
	if vehicle then
		vehicleModel = GetEntityModel(vehicle)

		if getVehicleBlacklist(vehicleModel) then
			TaskLeaveVehicle(Ped, vehicle, 1)
			
			if Config.Notify then
				ESX.ShowNotification(Config.NotifyMessage)
			end

			return true
		end
	end
	return false
end
