local QBCore = exports['qb-core']:GetCoreObject()

local Closest_Display = 1
local Zones = {}

-- Functions --

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function configureBlip(location)
    RentalBlip = AddBlipForCoord(location.rental_coords.x, location.rental_coords.y, location.rental_coords.z)
    SetBlipColour(RentalBlip, 0)
    SetBlipSprite(RentalBlip, 106)
    SetBlipScale(RentalBlip, 0.6)
    SetBlipDisplay(RentalBlip, 4)
    SetBlipAsShortRange(RentalBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Label)
    EndTextCommandSetBlipName(RentalBlip)
end

local function getDisplayHeaderMenu()
    local headerMenu = {
        {
            header = Config.Label,
            txt = 'View bicycles for rent',
            params = {
                event = 'qb-bikerental:client:openBikeMenu'
            }
        }
    }
    return headerMenu
end

local function setClosestDisplay()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, v in pairs(Config.RentalLocations) do
        local dist2 = #(pos - vector3(v.rental_coords.x, v.rental_coords.y, v.rental_coords.z))
        if current ~= nil then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= Closest_Display then
        Closest_Display = current
    end
end

local function createVehicleDisplayZones()
    for k, v in pairs(Config.RentalLocations) do
        Zones[#Zones + 1] = BoxZone:Create(
                vector3(v.rental_coords.x, v.rental_coords.y, v.rental_coords.z),
                3,
                3, {
                    name = "box_zone",
                    debugPoly = false,
                })
    end
    local combo = ComboZone:Create(Zones, { name = "vehCombo", debugPoly = false })
    combo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            setClosestDisplay()
            if Config.WalkUpRentalMenu then
                local menu = getDisplayHeaderMenu()
                exports['qb-menu']:openMenu(menu)
            end
        else
            if Config.WalkUpRentalMenu then
                exports['qb-menu']:closeMenu()
            end
        end
    end)
end

-- Events --

RegisterNetEvent('qb-bikerental:client:openBikeMenu', function()
    local ordered_keys = {}
    for k in pairs(Config.Bikes) do
        table.insert(ordered_keys, k)
    end
    table.sort(ordered_keys)
    local bikeMenu = {
        {
            header = "Bicycles for Rent",
            isMenuHeader = true
        }
    }
    for i = 1, #ordered_keys do
        local v = Config.Bikes[ordered_keys[i]]
        if v.available then
            bikeMenu[#bikeMenu + 1] = {
                header = v.label,
                txt = 'To Rent: $' .. v.rental_cost .. '',
                params = {
                    isServer = true,
                    event = 'qb-bikerental:server:swapVehicle',
                    args = {
                        vehicle = v
                    }
                }
            }
        end
    end
    bikeMenu[#bikeMenu + 1] = {
        header = 'Cancel',
        params = {
            event = 'qb-menu:client:closeMenu'
        }
    }
    exports['qb-menu']:openMenu(bikeMenu)
end)

RegisterNetEvent('qb-bikerental:client:swapVehicle', function(data)
    local bike = data.vehicle
    local model = bike.model
    local displaySpot = Config.RentalLocations[Closest_Display]
    if displaySpot.chosen_veh ~= model then
        local closestVehicle, closestDistance = QBCore.Functions.GetClosestVehicle(vector3(displaySpot.rental_coords.x, displaySpot.rental_coords.y, displaySpot.rental_coords.z))
        if closestVehicle == 0 then
            return
        end
        if closestDistance < 5 then
            QBCore.Functions.DeleteVehicle(closestVehicle)
        end
        Citizen.Wait(250)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(250)
        end
        local newVeh = CreateVehicle(model, displaySpot.rental_coords.x, displaySpot.rental_coords.y, displaySpot.rental_coords.z, false, false)
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(newVeh)
        SetEntityInvincible(newVeh, true)
        --SetEntityHeading(newVeh, displaySpot.rental_coords.w)
        SetVehicleDoorsLocked(newVeh, 3)
        FreezeEntityPosition(newVeh, true)
        SetVehicleNumberPlateText(newVeh, 'RENT ME')
        Config.RentalLocations[Closest_Display].chosen_veh = model
    end
end)

RegisterNetEvent('qb-bikerental:client:openBikeRentalConfirmationMenu', function(data)
    local bike = data.vehicle
    local menu = {
        {
            header = 'Is this the bicycle you want to rent?',
            isMenuHeader = true
        },
        {
            header = bike.label .. '',
            txt = 'To Rent: $' .. bike.rental_cost .. ''
        },
        {
            header = 'No, take me back!',
            params = {
                event = 'qb-bikerental:client:openBikeMenu'
            }
        },
        {
            header = 'Yes, please!',
            params = {
                event = 'qb-bikerental:client:RentBike',
                args = {
                    vehicle = bike
                }
            }
        }
    }
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-bikerental:client:RentBike', function(data)
    local bike = data.vehicle
    local model = bike.model
    local cost = bike.rental_cost
    local spawn = Config.RentalLocations[Closest_Display].spawn_coords
    local x = spawn.x
    local y = spawn.y
    local z = spawn.z
    QBCore.Functions.TriggerCallback('qb-bikerental:server:CanRentBike', function(can)
        if can then
            QBCore.Functions.SpawnVehicle(model, function(ent)
                SetEntityCoords(ent, x, y, z)
                TaskWarpPedIntoVehicle(PlayerPedId(), ent, -1)
                SetEntityAsMissionEntity(ent, true, true)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(ent))
            end)
        else
            QBCore.Functions.Notify("You don't have enough money!")
        end
    end, cost)
end)

-- Threads --

-- Display bikes + zone & blip config
Citizen.CreateThread(function()
    for k, v in pairs(Config.RentalLocations) do
        if v.active then
            local model = GetHashKey(v.default_veh)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            local veh = CreateVehicle(model, v.rental_coords.x, v.rental_coords.y, v.rental_coords.z, false, false)
            SetModelAsNoLongerNeeded(model)
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleOnGroundProperly(veh)
            SetEntityInvincible(veh, true)
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleDoorsLocked(veh, 3)
            --SetEntityHeading(veh, v.rental_coords.w)
            FreezeEntityPosition(veh, true)
            SetVehicleNumberPlateText(veh, 'RENT ME')
            configureBlip(v)
        end
    end
    createVehicleDisplayZones()
end)

-- Bike rental walk up config
Citizen.CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            for k, v in pairs(Config.RentalLocations) do
                if v.active then
                    local dist = #(pos - v.rental_coords)
                    if dist < 12 then
                        DrawMarker(2, v.rental_coords.x, v.rental_coords.y, v.rental_coords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 109, 255, 0, 0.64, 0, 0, 0, 1, 0, 0, 0)
                        if not Config.WalkUpRentalMenu and dist < 2 then
                            DrawText3Ds(v.rental_coords.x, v.rental_coords.y, v.rental_coords.z + 0.9, '~g~E~w~ - View Bicycles for Rent')
                            if IsControlJustPressed(0, 38) then
                                setClosestDisplay()
                                TriggerEvent('qb-bikerental:client:openBikeMenu')
                            end
                        end
                        inRange = true
                    end
                end
            end
            if not inRange then
                Citizen.Wait(2000)
            end
        end
        Citizen.Wait(3)
    end
end)