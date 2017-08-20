local skynet = require "skynet"

local agentPool = {}
local onlineAgent = {}

local CMD = {}
local SOCKET = {}
local gate
local agent = {}

function SOCKET.open(config)
	logger.log(skyLog.INFO, "watchdog open!")

	local count = config.pool or 0
	for i = 1, n do
		table.insert(agentPool, skynet.newservice("agent"))
	end
end

function SOCKET.close(agent, account, fd)
	logger.log(skyLog.INFO, "agent %d recycled!", agent)	--?

	skynet.call(gate, "lua", "kick", fd)
	onlineAgent[account] = nil

	table.insert(agentPool, agent)		--回收
end

function SOCKET.login(fd, account)
	local agent = onlineAgent[account]
	if agent then
		logger.log(skyLog.WARN, "multiple login for account%d!", account)

		skynet.call(agent, "lua", "kick", account)
	else
		if #agentPool == 0 then
			logger.log(skyLog.INFO, "agentPool is empty!")
			agent = skynet.newservice("agent")
		else
			logger.log(skyLog.INFO, "agent(%d) assigned, %d remain in pool!", agent, #pool)
			agent = table.remove(agentPool, 1)
		end

		onlineAgent[account] = agent
		skynet.call(agent, "lua", "open", fd, account)
	end

	return agent
end

function CMD.start(conf)
	skynet.call(gate, "lua", "open" , conf)
end

function CMD.close(fd)
	close_agent(fd)
end

skynet.start(function()
	skynet.dispatch("lua", function(session, source, cmd, subcmd, ...)
		if cmd == "socket" then
			local f = SOCKET[subcmd]
			f(...)
			-- socket api don't need return
		else
			local f = assert(CMD[cmd])
			skynet.ret(skynet.pack(f(subcmd, ...)))
		end
	end)

	gate = skynet.newservice("gate")
end)
