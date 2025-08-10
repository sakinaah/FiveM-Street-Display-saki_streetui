local function GetCardinalDirection(heading)
    local directions = { "N", "NE", "E", "SE", "S", "SW", "W", "NW" }
    local index = math.floor((heading + 22.5) / 45) % 8 + 1
    return directions[index]
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local heading = GetEntityHeading(vehicle)
            local direction = GetCardinalDirection(heading)

            local coords = GetEntityCoords(ped)
            local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local streetName = "Unknown"
            if street1 ~= 0 then
                streetName = GetStreetNameFromHashKey(street1)
                if street2 ~= 0 then
                    streetName = streetName .. " / " .. GetStreetNameFromHashKey(street2)
                end
            end

            SendNUIMessage({
                type = "updateHUD",
                direction = direction,
                location = streetName
            })

        else
            SendNUIMessage({ type = "hideHUD" })
            Citizen.Wait(500)
        end
    end
end)
