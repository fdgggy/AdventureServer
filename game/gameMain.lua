local skynet = require "skynet"

skynet.start(function ()
	skynet.uniqueservice("logserver")
	logger.log(skyLog.INFO, "Hello skynet!!!")

	if not skynet.getenv("daemon") then
		skynet.newservice("console")
	end
	--debug_console
	skynet.uniqueservice("redisService")

	local redis = require "Dao"
	redis.set("AAA", "HelloKitty")
	local r2 = redis.get("AAA")
	logger.log(skyLog.INFO, "r2=%s", r2)
end)