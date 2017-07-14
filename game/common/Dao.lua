local skynet = require "skynet"

local Dao = {}

--redis  string
function Dao.set(k, v)
	return skynet.call("redis_service", "lua", "set", k, v)
end

function Dao.get(k)
	return skynet.call("redis_service", "lua", "get", k)
end
--redis

return Dao