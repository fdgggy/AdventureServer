
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

-- lua扩展
function traceback(msg)
	msg = debug.traceback(msg, 2)
    --skynet.error(msg);
    LOG_ERROR(msg);
end

-- lua面向对象扩展
function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        superType = nil
        super = nil
    end

    if superType == "function" or(super and super.__ctype == 1) then
        -- inherited from native C++ Object
        cls = { }

        if superType == "table" then
            -- copy fields from super
            for k, v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super = super
        else
            cls.__create = super
            cls.ctor = function() end
        end

        cls.__cname = classname
        cls.__ctype = 1

        function cls.New(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k, v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        -- inherited from Lua Object
        if super then
            cls = { }
            setmetatable(cls, { __index = super })
            cls.super = super
        else
            cls = { ctor = function() end }
        end

        cls.__cname = classname
        cls.__ctype = 2
        -- lua
        cls.__index = cls

        function cls.New(...)
            local instance = setmetatable( { }, cls)
            instance.class = cls
            instance:ctor(...)
            return instance
        end
    end

    return cls
end

table.removeValue = function(t, rv)
    for k, v in pairs(t) do
        if v == rv then
            t[k]=nil
            break
        end
    end
end