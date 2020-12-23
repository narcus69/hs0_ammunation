ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


ConfHs0              = {}
ConfHs0.DrawDistance = 100
ConfHs0.Size         = {x = 1.0, y = 1.0, z = 1.0}
ConfHs0.Color        = {r = 255, g = 255, b = 255}
ConfHs0.Type         = 20

local position = {
        {x =   -662.1,   y = -935.3,  z = 21.8},
        {x =    810.2,   y = -2157.3, z = 29.6},
        {x =   1693.4,   y = 3759.5,  z = 34.7},
        {x =   -330.2,   y = 6083.8,  z = 31.4},
        {x =    252.3,   y = -50.0,   z = 69.9},
        {x =     22.0,   y = -1107.2, z = 29.8},
        {x =   2567.6,   y = 294.3,   z = 108.7},        
        {x =  -1117.5,   y = 2698.6,  z = 18.5},
        {x = -1305.81,   y = -394.34, z = 36.7},        
        {x =    842.4,   y = -1033.4, z = 28.1}          
}  

Citizen.CreateThread(function()
     for k in pairs(position) do
        local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
        SetBlipSprite(blip, 110)
        SetBlipColour(blip, 47)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Ammunation")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (ConfHs0.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < ConfHs0.DrawDistance) then
                DrawMarker(ConfHs0.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfHs0.Size.x, ConfHs0.Size.y, ConfHs0.Size.z, ConfHs0.Color.r, ConfHs0.Color.g, ConfHs0.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

RMenu.Add('hs0_ammunation', 'main', RageUI.CreateMenu("Ammunation", "Armurerie"))
RMenu.Add('hs0_ammunation', 'shop', RageUI.CreateSubMenu(RMenu:Get('hs0_ammunation', 'main'), "Armurerie", "Voici nos armes létal."))
RMenu.Add('hs0_ammunation', 'armurerie', RageUI.CreateSubMenu(RMenu:Get('hs0_ammunation', 'main'), "Armurerie", "Voici nos armes blanche."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('hs0_ammunation', 'main'), true, true, true, function()

            RageUI.Button("Armes létal", "Pour accéder aux armes.", {RigtLabel = "→→→"},true, function()
            end, RMenu:Get('hs0_ammunation', 'shop')) 


            RageUI.Button("Armes blanche", "Pour accéder aux armes.", {RigtLabel = "→→→"},true, function()
            end, RMenu:Get('hs0_ammunation', 'armurerie')) 


        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('hs0_ammunation', 'shop'), true, true, true, function()

                        RageUI.Button("Pistolet", nil, {RightLabel = "~g~5000$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "weapon_pistol"
            	local prix = 5000
                TriggerServerEvent('hs0_ammunation:acheter', item, prix)
            end
            end)


                        RageUI.Button("Pistolet Calibre 50", nil, {RightLabel = "~g~7500$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "weapon_pistol50"
            	local prix = 5000
                TriggerServerEvent('hs0_ammunation:acheter', item, prix)
            end
            end)
           

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('hs0_ammunation', 'armurerie'), true, true, true, function()

                        RageUI.Button("Couteau", nil, {RightLabel = "~g~500$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "weapon_knife"
            	local prix = 500
                TriggerServerEvent('hs0_ammunation:acheter', item, prix)
            end
            end)


                        RageUI.Button("Batte", nil, {RightLabel = "~g~250$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "weapon_bat"
            	local prix = 250
                TriggerServerEvent('hs0_ammunation:acheter', item, prix)
            end
            end)
           

        end, function()
        end)

        Citizen.Wait(0)
    end
end)



Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au shop")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('hs0_ammunation', 'main'), not RageUI.Visible(RMenu:Get('hs0_ammunation', 'main')))
                    end   
                end
            end
        end
    end)