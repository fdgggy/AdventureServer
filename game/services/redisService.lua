local skynet = require "skynet"
local redis = require "skynet.db.redis"
require "skynet.manager"

local connect

skynet.start(function ()
	local conf = {
		host = skynet.getenv("redishost"),
		port = skynet.getenv("redisport"),
		db = tonumber(skynet.getenv("redisbase")),
	}
	connect = redis.connect(conf)

	if not connect then
		logger.log(skyLog.ERROR, "connect redis error!")
	else
		logger.log(skyLog.INFO, "connect redis success!")

		skynet.dispatch("lua", function (seddion, source, cmd, ...)
			assert(connect, "redis is not connect!")

			local f = connect[cmd]
			local res = f(connect, ...)
			if not res then
				logger.log(skyLog.ERROR, "excuse %s command failed!", cmd)
			end
			
			skynet.retpack(res)
		end)

		skynet.register("redis_service")
	end
end)