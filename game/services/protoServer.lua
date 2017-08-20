local skynet = require "skynet"

local sprotoHelper = require "sprotoHelper"

skynet.start (function ()
	sprotoHelper.init()
end)
