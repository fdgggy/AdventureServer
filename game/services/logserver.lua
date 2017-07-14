local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register

local CMD = {}

function CMD.start()
	-- body
end

function CMD.Debug(serviceName, msg)
	skynet.error(msg)
end

function CMD.Info(serviceName, msg)
	skynet.error(msg)
end

function CMD.Warning(serviceName, msg)
	skynet.error(msg)
end

function CMD.Error(serviceName, msg)
	skynet.error(msg)
end

function CMD.FATAL(serviceName, msg)
	skynet.error(msg)
end

skynet.start(function ()
	skynet.dispatch("lua", function (seddion, source, cmd, ...)
		local f = assert(CMD[cmd])
		f(...)
	end)

	skynet.register("LOG")
end)