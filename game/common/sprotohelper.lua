local sprotoloader = require "sprotoloader"

local loginp = require "proto.loginproto"
local gamep = require "proto.gameproto"

local sprotoHelper = {
	GameType = 0,	--自定义的结构

	LoginC2S = 1,
	LoginS2C = 2,
	GameC2S = 3,
	GameS2C = 4,
}

function sprotoHelper.init()
	sprotoloader.save (gamep.types, loader.GameType)

	sprotoloader.save (loginp.c2s, loader.LoginC2S)
	sprotoloader.save (loginp.s2c, loader.LoginS2C)

	sprotoloader.save (gamep.c2s, loader.GameC2S)
	sprotoloader.save (gamep.s2c, loader.GameS2C)
end

function sprotoHelper.load(index)
	local host = sprotoloader.load(index):host "package"
	local request = host:attach(sprotoloader.load(index + 1))
	return host, request
end

return sprotoHelper