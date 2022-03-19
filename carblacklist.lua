carblacklist = {
	"example1",
	"example2",
	"example3",
}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000) -- check time

		local xPlayer = ESX.GetPlayerData()

		if(xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "taxi" or xPlayer.job.name == "mechanic") then -- add hire more job's if needed	

		else
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
				playerPed = GetPlayerPed(-1)
				v = GetVehiclePedIsIn(playerPed, false)

				if playerPed and v then
					if GetPedInVehicleSeat(v, -1) == playerPed then
						if(checkCar(playerPed, v)) then
							Citizen.Wait(5000)
						end
					end
				end
			end
		end
	end
end)

function checkCar(playerPed, car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			TaskLeaveVehicle(playerPed, car, 1)

			-- You can set this on if you have pNotify in your server
			
			-- TriggerEvent("pNotify:SendNotification", {
			-- 	text = "This vehicle is only permitted for emergency services.",
			-- 	type = "error",
			-- 	timeout = 5000,
			-- 	layout = "bottomCenter"
			-- })

			return true
		end
	end

	return false
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end