local skynet = require "skynet"
local redis = require "skynet.db.redis"

local connect

skynet.start(function ()
	local conf = {
		host = skynet.getenv("redishost"),
		port = skynet.getenv("redisport"),
		db = tonumber(skynet.getenv("redisbase")),
	}
	connect = redis.connect(conf)

	if not connect then
		--error log
	else
		skynet.dispatch("lua", function (seddion, source, cmd, ...)
			if not connect then
				--log
			else
				
			end
		end)
	end
end)