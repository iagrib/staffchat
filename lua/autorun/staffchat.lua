-- StaffChat by Ia_grib

include("staffchat/config.lua")
if SERVER then
	include("staffchat/sv.lua")
	AddCSLuaFile("staffchat/config.lua")
	AddCSLuaFile("staffchat/cl.lua")
else include("staffchat/cl.lua") end