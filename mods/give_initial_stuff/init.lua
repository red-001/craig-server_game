minetest.register_on_newplayer(function(player)
	--print("on_newplayer")
	if minetest.setting_getbool("give_initial_stuff") then
		minetest.log("action", "Giving initial stuff to player "..player:get_player_name())
		player:get_inventory():add_item('main', 'default:pick_steel')
		player:get_inventory():add_item('main', 'default:shovel_steel')
		player:get_inventory():add_item('main', 'default:axe_steel')
		player:get_inventory():add_item('main', 'default:torch 20')
		player:get_inventory():add_item('main', 'default:cobble 99')
		player:get_inventory():add_item('main', 'default:wood 99')
		player:get_inventory():add_item('main', 'default:chest_locked')
		player:get_inventory():add_item('main', 'default:furnace')
		player:get_inventory():add_item('main', 'markers:mark 4')
		player:get_inventory():add_item('main', 'markers:stone')
		player:get_inventory():add_item('main', 'bitchange:bitcoin 25')
	end
end)
