local function printMsg()
	local room = net.ReadUInt(4)
	local msg = net.ReadString()
	local plr = net.ReadEntity()

	if not IsValid(plr) then return end

	chat.AddText(StaffChat.colors[2], "[", StaffChat.titles[room], "] ", StaffChat.colors[3], plr:Nick(), StaffChat.colors[4], " (", plr:SteamID(), ")", StaffChat.colors[2], ":", StaffChat.colors[StaffChat.read[room][plr:GetUserGroup()] and 5 or 6], msg)
end

net.Receive("StaffChat", printMsg)

local function printErr()
	local err = net.ReadUInt(2)
	if err == 1 then chat.AddText(StaffChat.colors[1], StaffChat.emptymsg)
	elseif err == 2 then chat.AddText(StaffChat.colors[1], StaffChat.noperm:gsub("{title}", StaffChat.titles[net.ReadUInt(2)])) end
end

net.Receive("StaffChat_Err", printErr)