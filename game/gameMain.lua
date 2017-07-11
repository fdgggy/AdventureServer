local skynet = require "skynet"

skynet.start(function ()
	skynet.error("Server start!!!")
	--日志服务
	if not skynet.getenv("daemon") then
		skynet.newservice("console")
	end
	--debug_console
	-- skynet.uniqueservice("db_service")

	skynet.uniqueservice("testredis")
end)