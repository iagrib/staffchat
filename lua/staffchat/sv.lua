util.AddNetworkString("StaffChat")
util.AddNetworkString("StaffChat_Err")

local noperm = StaffChat.noperm ~= ""
local emptymsg = StaffChat.emptymsg ~= ""

local function onChat(plr, msg)
	local cmd, rmsg = msg:match("^(%S+)(.*)")
	local room = StaffChat.cmds[cmd:lower()]
	if room then
		if StaffChat.write[room][plr:GetUserGroup()] then
			local msg = rmsg and string.Trim(rmsg)
			if msg and msg ~= "" then
				local plrs = player.GetAll()
				local filtered = {}
				for i = 1, #plrs do
					if plrs[i] == plr or StaffChat.read[room][plrs[i]:GetUserGroup()] then filtered[#filtered + 1] = plrs[i] end
				end
				net.Start("StaffChat")
				net.WriteUInt(room, 4)
				net.WriteString(msg)
				net.WriteEntity(plr)
				net.Send(filtered)

				ServerLog(plr:Nick().." ("..plr:SteamID()..") in "..StaffChat.titles[room]..": "..msg.."\n")
			elseif emptymsg then
				net.Start("StaffChat_Err")
				net.WriteUInt(1, 2)
				net.Send(plr)
			end
		elseif noperm then
			net.Start("StaffChat_Err")
			net.WriteUInt(2, 2)
			net.WriteUInt(room, 4)
			net.Send(plr)
		end
		return ""
	end
end

hook.Add("PlayerSay", "StaffChat", onChat)