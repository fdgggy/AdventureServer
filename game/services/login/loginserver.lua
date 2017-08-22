local skynet = require "skynet"
local loginMgr = require "loginserver"

skynet.start(function ()
	loginMgr.init()

	skynet.dispatch("lua", function (session, source, bserviceProtoTag, fd, addr, msgdata)
		if bserviceProtoTag then
		else
			--解析数据报
		end
	end)
end)
