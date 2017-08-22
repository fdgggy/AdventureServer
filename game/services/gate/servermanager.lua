--管理所有的服务
local skynet = require "skynet"

local serverMgr = {}

local servers = {}
--type服务类型, serverId服务ID, server服务实例 
function serverMgr.registerServer(type, serverId, server)
	logger.log(skyLog.INFO, "registerServer:[type:%s, serverId:%s, server:%s]", type, serverId, server)

	local serverHash = servers[type]
	if not serverHash then
		logger.log(skyLog.INFO, "create type:%s server hash!", type)
		serverHash[type] = {}
	end
	
	serverHash[type][serverId] = server
end

function serverMgr.unregisterServer(type, server)
	logger.log(skyLog.INFO, "unregisterServer:[type:%s, server:%s]", type, server)

	local serverHash = servers[type]
	if serverHash then
		table.removeValue(serverHash, server)
	else
		logger.log(skyLog.ERROR, "not exsit type:%s server!", type)
	end
end

function serverMgr.getServer(type, serverId)
	local serverHash = servers[type]
	if not serverHash then
		return false, "not exsit type=%s server!"..(type or 0)
	else
		return serverHash[serverId] or false, "not exsit serverId=%s server!"..(serverId or 0)
	end
end

function serverMgr.sendtogate(cmd, ...)
	skynet.send(globalCommon.serverType, "lua", cmd, ...)
end

function serverMgr.sendtoclient(fd, response)
	serverMgr.sendtogate(globalCommon.cmdType.SendtoClient, fd, response)
end

return serverMgr