StaffChat = {}
local c = {}

-- Config file

-- You can add multiple chat rooms with different chat commands and permissions
-- Please keep numbers in [] ordered (1, 2, 3...) or it won't work properly
-- Example:
--[[

c[2] = {
	cmds = {"/staff", "/staffchat"}, -- List of commands that can be used to write to this chat, separated by commas
	write = {"superadmin", "admin"}, -- List of usergroups that can write to this chat
	read = {"superadmin", "admin"}, -- List of usergroups that can read this chat
	title = "Example Chat" -- Title that will be displayed in chat for messages in this chat
}

]]--

c[1] = {
	cmds = {"/s"},
	write = {"superadmin", "admin"},
	read = {"superadmin", "admin"},
	title = "Staff Chat"
}



-- Error message: No permission
-- Will be displayed when a user attempts to write to a chat they don't have permission to write to
-- {title} will be replaces with its name (e.g. "Staff Chat")
-- Set to "" to disable.
StaffChat.noperm = "You don't have permission to use the {title}!"

-- Error message: Empty message
-- Will be used when a user attempts to use a command without typing any text (i. e. just "/s")
-- Set to "" to disable.
StaffChat.emptymsg = "Please enter a message."



-- Colors for messages
StaffChat.colors = {
	Color(255, 100, 100), -- 1 - Error messages (e.g. 'no permission')
	Color(255, 144, 0), -- 2 - Staff chat messages color 1 (room title)
	Color(255, 55, 0), -- 3 - Staff chat messages color 2 (player nickname)
	Color(122, 122, 122), -- 4 - Staff chat messages color 3 (player steamid)
	Color(255, 100, 100), -- 5 - Staff chat messages color 4 (message content)
	Color(255, 255, 255) -- 6 - Staff chat messages color 4 alternate (message content if sender doesn't have permission to read messages from that chat)
}

-- End of config file

StaffChat.cmds = {}
StaffChat.write = {}
StaffChat.read = {}
StaffChat.titles = {}

for i = 1, #c do
	StaffChat.cmds[i] = {}
	for cm = 1, #c[i].cmds do
		StaffChat.cmds[c[i].cmds[cm]] = i
	end
	StaffChat.write[i] = {}
	for w = 1, #c[i].write do
		StaffChat.write[i][c[i].write[w]] = true
	end
	StaffChat.read[i] = {}
	for r = 1, #c[i].read do
		StaffChat.read[i][c[i].read[r]] = true
	end
	StaffChat.titles[i] = c[i].title
end