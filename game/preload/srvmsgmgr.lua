local msgMgr = class()

msgMgr.listen = {}

function msgMgr:listenRequest(cmd, callBack)		--cmd <->{func1, func2, ...}
	local cmdList = self.listen[cmd]
	if not cmdList then
		cmdList = {}
		self.listen[cmd] = cmdList
	end

	table.insert(cmdList, callBack)
end

function msgMgr:dispatchRequest(cmd, ...)		--根据cmd依次派发
	local cmdList = self.listen[cmd]
	if cmdList then
		for i,v in ipairs(cmdList) do
			local ok = xpcall(v, traceback, ...)
			if not ok then
				logger.log(skyLog.ERROR, "cmd:%s excuse error!", cmd)
			end
		end
	else
		logger.log(skyLog.ERROR, "cmd:%s dispatch failed!", cmd)
	end
end

return msgMgr