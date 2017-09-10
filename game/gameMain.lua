local skynet = require "skynet"

skynet.start(function ()
	skynet.uniqueservice("logserver")
	logger.log(skyLog.INFO, "Hello skynet!!!")

	if not skynet.getenv("daemon") then
		skynet.newservice("console")
	end
	--debug_console
	skynet.uniqueservice("protoServer")
	skynet.uniqueservice("redisService")

	local gateserver = skynet.newservice("gate")
	skynet.call(gateserver, "lua", "open", {
		port = gateport,
		maxclient = maxclients,
		nodelay = true,
	})

	local redis = require "Dao"
	redis.set("AAA", "HelloKitty")
	local r2 = redis.get("AAAa")
	logger.log(skyLog.INFO, "r2=%s", r2)

	local a ={
		aa = "hah",
		zz = 2,
		c = "ci"
}
	redis.hmset("BBB", a)

	local r = redis.hmget("BBB", "zz")
	print("r="..r)

	local rr = redis.hgetall("BBB")
	print("rr="..util.tableDump(rr))

	local fs = {
		x = 5,
		a = 43,
		z = 76,
		jj = 0,
}
	for k,v in pairs(fs) do
		local xx = redis.zadd("fx", v, k)
		print("xx="..xx)
	end


	local fjj = redis.zrevrange("fx", 0, 4, true)
	print("rr="..util.tableDump(fjj))
end)