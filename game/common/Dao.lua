local skynet = require "skynet"
local unpack =table.unpack

local Dao = {}

--redis  string
function Dao.set(k, v)
	return skynet.call("redis_service", "lua", "SET", k, v)
end

function Dao.get(k)	
	return skynet.call("redis_service", "lua", "GET", k)	--如果没有返回nil
end
-- Hash  f->v f->v
function Dao.hmset(k, t)
	assert(type(t) == "table")

	local data = {}
	for k,v in pairs(t) do
		table.insert(data, k)
		table.insert(data, v)
	end

	return skynet.call("redis_service", "lua", "HMSET", k, unpack(data))
end

function Dao.hmget(k, f, ...)
	local res = skynet.call("redis_service", "lua", "HMGET", k, f, ...)
	if util.tableIsEmpty(res) then
		return nil
	end

	return res[1]
end

function Dao.hgetall(k)
	local res = skynet.call("redis_service", "lua", "HGETALL", k)

	if util.tableIsEmpty(res) then
		return nil
	end

	return util.tablePack(res)
end

--sorted set
function Dao.zadd(k, score, member)
	return skynet.call("redis_service", "lua", "ZADD", k, score, member)
end

--返回指定成员分数
function Dao.zscore(k, m)
	return skynet.call("redis_service", "lua", "ZSCORE", k, m)
end

--返回指定成员排名，从小到大
function Dao.zrank(k, m)
	return skynet.call("redis_service", "lua", "ZRANK", k, m)
end

--返回指定成员排名，从大到小
function Dao.zrevrank(k, m)
	return skynet.call("redis_service", "lua", "ZREVRANK", k, m)
end

--返回有序集中，指定区间内的成员(从小到大)来排序
function Dao.zrange(k, from, to, withScore)
	local res
	if withScore then
		res = skynet.call("redis_service", "lua", "ZRANGE", k, from, to, "WITHSCORES")
	else
		res = skynet.call("redis_service", "lua", "ZRANGE", k, from, to)
	end
	
	
	if util.tableIsEmpty(res) then
		return nil
	end

	if withScore then
		return util.tablePack(res)  --k->v table
	else
		return res   --table
	end
end

--返回有序集中，指定区间内的成员(从大到小)来排序
function Dao.zrevrange(k, from, to)
	local res
	if withScore then
		res = skynet.call("redis_service", "lua", "ZREVRANGE", k, from, to, "WITHSCORES")
	else
		res = skynet.call("redis_service", "lua", "ZREVRANGE", k, from, to)
	end
	
	
	if util.tableIsEmpty(res) then
		return nil
	end

	if withScore then
		return util.tablePack(res)  --k->v table
	else
		return res   --table
	end
end
--redis

return Dao