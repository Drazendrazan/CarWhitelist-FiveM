Config = {}

Config = {
    carsblacklisted = { -- put here the vehicles that you want only emergency services to be able to get in
        "police",
        "police2",
        "police3",
        "ambulance",
    },
    pNotify = false, -- if you have pnotify you can turn it on for a different message
    EsxNotify = true, -- Turn this on for the default ESX notification
    CheckTime = 1000, -- Check time in car, please don't go onder 1000ms if you want a good and stable server
    NotifyMessage = 'This vehicle is for emergency services only',
}