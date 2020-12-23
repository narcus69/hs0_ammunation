ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hs0_ammunation:acheter')
AddEventHandler('hs0_ammunation:acheter', function(item, prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if playerMoney >= prix then
		xPlayer.addWeapon(item, 42)
		xPlayer.removeMoney(prix)
		TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~"..item.." ~s~!")
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez !")
	end
end)
