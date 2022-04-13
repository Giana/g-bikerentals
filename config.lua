Config = {}

Config.Label = "Bike Rental"        -- Label for locations on map

Config.WalkUpRentalMenu = false     -- True == Walk up to display to open rental menu, False == Must manually press key at display to open rental menu

--[[
    For each Config.RentalLocations[x]:
    - label: Name of the location
        - Not currently in use, more so for knowing which location we're looking at in the
          config without having to go to the coordinates in game
    - rental_coords: The coordinates of the interactable bike rental display
        - Change to vector4, add w coordinate, and uncomment the SetEntityHeading() calls in
          client/main.lua if you want to configure the direction bike displays are facing
    - spawn_coords: The coordinates a player spawns at on bike when they rent a bike
    - default_veh: The default bike model displayed to players
    - chosen_veh: The current bike model displayed to players
        - Dynamic, changes for everyone when the player changes the bike display
    - active: If the location is active
        - Set to false to disable rentals at this location (location and display will not appear on map or to players at all)
]]
Config.RentalLocations = {
    [1] = {
        label = "Fantastic Plaza",
        rental_coords = vector3(292.65, -1072.83, 28.41), spawn_coords = vector4(294.57, -1075.61, 29.41, 181.37),
        default_veh = 'bmx', chosen_veh = 'bmx',
        active = true
    },
    [2] = {
        label = "Integrity Way",
        rental_coords = vector3(256.53, -634.12, 39.78), spawn_coords = vector4(260.08, -631.43, 41.11, 334.13),
        default_veh = 'cruiser', chosen_veh = 'cruiser',
        active = true
    },
    [3] = {
        label = "Morningwood Blvd",
        rental_coords = vector3(-1281.39, -425.83, 33.66), spawn_coords = vector4(-1282.16, -429.49, 34.79, 211.71),
        default_veh = 'fixter', chosen_veh = 'fixter',
        active = true
    },
    [4] = {
        label = "South Rockford Drive",
        rental_coords = vector3(-675.91, -1104.71, 13.53), spawn_coords = vector4(-672.75, -1099.81, 14.6, 335.77),
        default_veh = 'scorcher', chosen_veh = 'scorcher',
        active = true
    },
    [5] = {
        label = "Tinsel Towers",
        rental_coords = vector3(-614.74, 31.94, 42.53), spawn_coords = vector4(-615.69, 22.92, 41.61, 266.41),
        default_veh = 'tribike', chosen_veh = 'tribike',
        active = true
    },
    [6] = {
        label = "Airport",
        rental_coords = vector3(-770.03, -2056.51, 8.02), spawn_coords = vector4(-773.72, -2053.14, 9.02, 46.45),
        default_veh = 'tribike2', chosen_veh = 'tribike2',
        active = true
    },
    [7] = {
        label = "Maze Bank Arena",
        rental_coords = vector3(-226.28, -1877.15, 27.77), spawn_coords = vector4(-221.17, -1878.5, 28.64, 242.66),
        default_veh = 'tribike3', chosen_veh = 'tribike3',
        active = true
    },
    [8] = {
        label = "Pleasure Pier",
        rental_coords = vector3(-1574.49, -876.66, 9.14), spawn_coords = vector4(-1570.91, -872.99, 10.13, 316.49),
        default_veh = 'bmx', chosen_veh = 'bmx',
        active = true
    },
    [9] = {
        label = "Vinewood Bowl",
        rental_coords = vector3(733.64, 659.77, 128.05), spawn_coords = vector4(736.58, 659.88, 129.05, 253.7),
        default_veh = 'cruiser', chosen_veh = 'cruiser',
        active = true
    },
    [10] = {
        label = "Harmony",
        rental_coords = vector3(611.49, 2744.88, 40.97), spawn_coords = vector4(606.83, 2743.2, 42.0, 91.63),
        default_veh = 'fixter', chosen_veh = 'fixter',
        active = true
    },
    [11] = {
        label = "Grapeseed",
        rental_coords = vector3(1683.74, 4828.33, 41.02), spawn_coords = vector4(1682.03, 4824.93, 42.01, 184.02),
        default_veh = 'scorcher', chosen_veh = 'scorcher',
        active = true
    },
    [12] = {
        label = "El Gordo Drive",
        rental_coords = vector3(3331.06, 5160.21, 17.25), spawn_coords = vector4(3329.61, 5154.95, 18.3, 137.56),
        default_veh = 'tribike', chosen_veh = 'tribike',
        active = true
    },
    [13] = {
        label = "Paleto Bay",
        rental_coords = vector3(-12.6, 6507.58, 30.53), spawn_coords = vector4(-14.62, 6504.74, 31.54, 136.32),
        default_veh = 'tribike2', chosen_veh = 'tribike2',
        active = true
    },
    [14] = {
        label = "Raton Canyon Trails",
        rental_coords = vector3(-1491.81, 4979.68, 62.38), spawn_coords = vector4(-1494.91, 4976.02, 63.53, 179.65),
        default_veh = 'tribike3', chosen_veh = 'tribike3',
        active = true
    },
    [15] = {
        label = "Mount Chiliad",
        rental_coords = vector3(509.83, 5530.33, 775.82), spawn_coords = vector4(496.07, 5532.88, 778.36, 130.45),
        default_veh = 'bmx', chosen_veh = 'bmx',
        active = true
    },
    [16] = {
        label = "Braddock Farm",
        rental_coords = vector3(2501.2, 5114.1, 45.28), spawn_coords = vector4(2507.3, 5116.1, 46.4, 281.74),
        default_veh = 'cruiser', chosen_veh = 'cruiser',
        active = true
    },
    [17] = {
        label = "Chumash",
        rental_coords = vector3(-3127.9, 1121.12, 19.66), spawn_coords = vector4(-3126.75, 1125.24, 20.66, 353.7),
        default_veh = 'fixter', chosen_veh = 'fixter',
        active = true
    },
    [18] = {
        label = "Kortz Center",
        rental_coords = vector3(-2318.9, 452.0, 173.6), spawn_coords = vector4(-2319.65, 446.04, 174.6, 174.28),
        default_veh = 'scorcher', chosen_veh = 'scorcher',
        active = true
    },
    [19] = {
        label = "Tataviam Mountains",
        rental_coords = vector3(1211.96, -278.55, 68.08), spawn_coords = vector4(1208.26, -274.81, 69.08, 35.14),
        default_veh = 'tribike', chosen_veh = 'tribike',
        active = true
    },
    [20] = {
        label = "Galileo Observatory",
        rental_coords = vector3(-421.05, 1221.16, 324.77), spawn_coords = vector4(-419.43, 1225.35, 325.76, 339.56),
        default_veh = 'tribike2', chosen_veh = 'tribike2',
        active = true
    },
}

--[[
    For each Config.Bikes[x]:
    - model: The bike model
    - label: The name of the bike as is displayed to the player
    - rental_cost: The cost to rent this bike
    - available: If the bike is available for rent
        - Set to false to remove this bike from available rentals
]]
Config.Bikes = {
    [1] = { model = "bmx", label = "BMX", rental_cost = 12, available = true },
    [2] = { model = "cruiser", label = "Cruiser", rental_cost = 10, available = true },
    [3] = { model = "fixter", label = "Fixter", rental_cost = 20, available = true },
    [4] = { model = "scorcher", label = "Scorcher", rental_cost = 15, available = true },
    [5] = { model = "tribike", label = "Tribike", rental_cost = 22, available = true },
    [6] = { model = "tribike2", label = "Tribike 2", rental_cost = 22, available = true },
    [7] = { model = "tribike3", label = "Tribike 3", rental_cost = 22, available = true },
}