local QBCore = exports['qb-core']:GetCoreObject()

-- Events --

RegisterNetEvent('qb-bikerental:server:swapVehicle', function(data)
    local src = source
    TriggerClientEvent('qb-bikerental:client:swapVehicle', -1, data)
    Wait(1500)
    TriggerClientEvent('qb-bikerental:client:openBikeRentalConfirmationMenu', src, data)
end)

-- Callbacks --

QBCore.Functions.CreateCallback('qb-bikerental:server:CanRentBike', function(source, cb, rentalCost)
    local player = QBCore.Functions.GetPlayer(source)
    if player.Functions.GetMoney('cash') >= rentalCost then
        player.Functions.RemoveMoney('cash', rentalCost, 'Bike rental')
        cb(true)
    elseif player.Functions.GetMoney('bank') >= rentalCost then
        player.Functions.RemoveMoney('bank', rentalCost, 'Bike rental')
        cb(true)
    else
        cb(false)
    end
end)