local skynet = require "skynet"
--全局
logger = {
	DEBUG = "Debug",
	INFO = "Info",
	WARN = "Warning",
	ERROR = "Error",
	FATAL = "FATAL"
}


function logger.log(level, str, ...)
	local time = os.date("%Y-%m-%d %H:%M:%S", os.time())  
	local info = debug.getinfo(2)
	local msg = string.format("[%s::][%s %s:%d]", level, time, info.short_src, info.currentline)
	skynet.error(msg)
	-- skynet.send("LOG", "lua", level, SERVICE_NAME, msg)
end