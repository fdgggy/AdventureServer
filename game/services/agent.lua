local skynet = require "skynet"

local CMD = {}

function CMD.open( ... )
	-- body
end

function CMD.close( ... )
	-- body
end

function CMD.gameEnter( ... )
	-- body
end

skynet.start(function()
	skynet.dispatch("lua", function(_,_, command, ...)
		local f = CMD[command]
		skynet.ret(skynet.pack(f(...)))
	end)
end)