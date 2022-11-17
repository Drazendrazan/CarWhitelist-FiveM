Config = {}

Config.OldESX = false -- Set true not using ESX Legacy but an older ESX version

Config.emergencyJobs = { -- put here the job that you want to drive in the emergencyVehicles below
    'police',
    'ambulance',
    'mechanic', 
    'taxi'
}

Config.emergencyVehicles = { -- put here the vehicles that you want only emergency services to be able to get in
    "police",
    "ambulance",
    "flatbed",
    "taxi"
}

Config.Notify = true -- Turn this on for the default ESX notification

Config.CheckTime = 1000 -- Check time if person is in emergency vehicle, don't go onder 1000ms if you want a good and stable server

Config.NotifyMessage = 'This vehicle is for emergency services only' -- The message if the person is kicked out of the vehicle