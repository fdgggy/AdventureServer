local skynet = require "skynet"
--全局
skyLog = {
	DEBUG = "Debug",
	INFO = "Info",
	WARN = "Warning",
	ERROR = "Error",
	FATAL = "FATAL"
}

logger = {}

function logger.log(level, fmt, ...)
	local time = os.date("%Y-%m-%d %H:%M:%S", os.time())  
	local info = debug.getinfo(2)
	local msg = string.format(fmt, ...)
	msg = string.format("[%s %s:%d][%s] %s", time, info.short_src, info.currentline, level, msg)

	skynet.send("LOG", "lua", level, SERVICE_NAME, msg)
end
