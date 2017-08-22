local globalCommon = {}

globalCommon.serverType = {			
	Login = "LoginServer",
	Gate = "GateServer",
	Logic = "LogicServer", 
	Log = "LogServer",
	Redis = "RedisServer"
}

globalCommon.cmdType = {
	SendtoClient = "SendtoClient",
	OpenGate = "OpenGate",
	CloseGate = "CloseGate",
}

return globalCommon