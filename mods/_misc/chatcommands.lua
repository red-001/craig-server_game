--
-- Edited chat commands from core
--

-- /me
-- /help
-- /privs
-- /grant
-- /revoke
-- /setpassword
-- /clearpassword
-- /auth_reload
-- /teleport
-- /set
-- /deleteblocks
-- /mods
-- /give
-- /giveme
-- /spawnentity
-- /pulverize
-- /rollback_check
-- /rollback
-- /status
-- /time
-- /shutdown

minetest.register_chatcommand("ban", {
	params = "<name>",
	description = "Ban IP of player",
	privs = {ban=true},
	func = function(name, param)
		return false, "/ban is not in use. Please use /xban instead."
	end,
})

minetest.register_chatcommand("unban", {
	params = "<name/ip>",
	description = "remove IP ban",
	privs = {ban=true},
	func = function(name, param)
		return false, "/unban is not in use. Please use /xunban instead."
	end,
})

-- /kick
-- /clearobjects

minetest.register_chatcommand("msg", {
	params = "<name> <message>",
	description = "Send a private message",
	privs = {shout=true},
	func = function(name, param)
		local sendto, message = param:match("^(%S+)%s(.+)$")
		if not sendto then
			return false, "Invalid usage, see /help msg."
		end
		if not core.get_player_by_name(sendto) then
			return false, "The player " .. sendto
					.. " is not online."
		end
		core.log("action", "PM from " .. name .. " to " .. sendto
				.. ": " .. message)
		core.chat_send_player(sendto, "PM from " .. name .. ": "
				.. message)
		return true, "Message sent."
	end,
})

-- /last-login

--
-- Other chat commands
--

-- Spawn command
minetest.register_chatcommand("spawn", {
    params = "",
    description = "Teleport to the spawn location.",
    privs = {shout=true},
    func = function(name, param)
            local player = minetest.get_player_by_name(name)
            minetest.chat_send_player(name, "Teleported to spawn!")
            player:setpos(minetest.string_to_pos(minetest.setting_get("static_spawnpoint")))
            return true
    end,
})

-- Sethome command
minetest.register_chatcommand("sethome", {
        params = "",
        description = "Set your home location.",
        privs = {shout=true},
        func = function(name, param)
                local player = minetest.get_player_by_name(name)
                test = player:getpos()
                local file = io.open(minetest.get_worldpath().."/home/"..player:get_player_name().."_home", "w")
                if not file then
                        minetest.chat_send_player(name, "There was an error, please contact the server owner.")
                        return
                end
                file:write(minetest.pos_to_string(test))
                file:close()
                minetest.chat_send_player(name, "Your home location is set! Type /home to teleport back here.")
        end
})

-- Home command
minetest.register_chatcommand("home", {
	params = "",
	description = "Teleport to your home location.",
	privs = {shout=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local file = io.open(minetest.get_worldpath().."/home/"..player:get_player_name().."_home", "r")
		if not file then
			minetest.chat_send_player(name, "You haven't set your home! Set one using /sethome.")
			return
		end
		local line = file:read("*line")
		file:close()
		local pos = minetest.string_to_pos(string.sub(line, 1, string.find(line, ")")))
		if not pos or type(pos) ~= "table" then
			minetest.chat_send_player(name, "There was an error, please contact the server owner.")
			return
		end
		minetest.get_player_by_name(name):setpos(pos)
		minetest.chat_send_player(name, "Home sweet home.")
	end
})
