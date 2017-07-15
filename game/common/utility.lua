
util = {}

function util.tableDump(data)
	if type(data) ~= "table" then
		return ""
	end

	local str = "{ "
	for k,v in pairs(data) do
		local res
		if type(v) == "table" then
			res = util.tableDump(v)
		else
			res = v
		end
		str = str..k.."="..res..", "

	end

	return str.."}"
end

--基数为key，偶数为value
function util.tablePack(data)
	assert(type(data) == "table", "not a table")
	assert(util.tableNum(data) % 2 == 0, "not a right table")

	local t = {}
	for i,v in ipairs(data) do
		if i % 2 ~= 0 then
			t[v] = data[i + 1]
			i = i + 2
		end
	end

	return t
end

function util.tableIsEmpty(t)
	return (t == nil) or next(t) == nil
end

function util.tableNum(t)
	assert(type(t) == "table", "not a table")
	local c = 0

	for k,v in pairs(t) do
		c = c + 1
	end

	return c
end
