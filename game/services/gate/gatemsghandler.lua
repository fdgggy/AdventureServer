--网关消息处理器，结合网关用

local netpack = require "netpack"
local socketdriver = require "socketdriver"
local serverMgr = require "servermanager"
local srvmsgMgr = require "srvmsgmgr"


local msghandler = {}
local connection = {}
-- local loginBalance = 1	--负载均衡

--消息处理
msghandler.srvmsgMgr = srvmsgMgr.New()
msghandler.srvmsgMgr:listenRequest(globalCommon.msgType.RegisterServer, serverMgr.registerServer)
msghandler.srvmsgMgr:listenRequest(globalCommon.msgType.SendToclientByFd, msghandler.sendtoClient)

msghandler.gateProxy = nil			--网关代理

function msghandler.sendtoClient(fd, response)
	local user = connection[fd]
	if user then
		local res = string.pack(">s2", response)	--带2字节大端二进制字符串打包
		socketdriver.send(fd, res)
	else
		logger.log(skyLog.ERROR, "sendtoClient fd[%d] failed!", fd)
	end
end

-- function msghandler.addListen(cmdType, callBack)
-- 	serverMgr:listenRequest(cmdType, callBack)
-- end
-- msghandler.addListen(globalCommon.cmdType.SendtoClient, msghandler.sendtoClient)

-- function msghandler.dispatch(cmdType, ...)
-- 	serverMgr:dispatchRequest(cmdType, ...)
-- end

local function kick(fd)		--踢人
	-- body
end

function msghandler.open(source, conf)	--监听打开时
	-- body
end

function msghandler.connect(fd, msg)	--msg为addr，要验证, 有新连接时
	connection[fd] = {
		addr = msg,
		fd = fd,
		seq = 1,
	}
end

function msghandler.disconnect(fd, msg)	--kick	
	kick(fd)
end

function msghandler.error(fd, msg)	--
	logger.log(skyLog.ERROR, "socket error!fd:%d msg:%s", fd, msg)
	kick(fd)
end

function msghandler.warning(fd, size)	--
	logger.log(skyLog.WARN, "socket warning!fd:%d size:%s", fd, size)
end

function msghandler.message(fd, msg, sz)	
	local message = netpack.tostring(msg, sz)
	local seq = string.unpack(">I4", message, -4)
	local user = connection[fd]
	if user then
		if not user.roleId then		--没有就走登录

		else						--有就走逻辑服

		end
	else
		logger.log(skyLog.ERROR, "fd=%d not login!")
	end
end

