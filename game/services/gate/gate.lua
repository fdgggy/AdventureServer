local skynet = require "skynet"
local gateServer = require "gateserver"
local msgHandler = require "msghandler"

local gate = {}

function gate.start()
	gateServer.start(msgHandler)
end

gate.start()