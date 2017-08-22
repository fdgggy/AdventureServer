local debug = debug

print("hello")

local a = {}

function a:hah(s)
	local info = debug.getinfo(2)
	-- print(info.short_src)
	-- print(info.currentline)
	-- local index = string.find(info.short_src, "\\", -1)
	-- print(index)
	-- local str = string.sub(info.short_src, -1*(string.len(info.short_src) - index), -1)
	
	print(str)
	local time = os.date("%Y-%m-%d %H:%M:%S", os.time())  
	local msg = string.format("[%s %s:%d]::%s", time, info.short_src, info.currentline, s)
	print(msg)
end

a:hah("shahha")

local str = string.pack(">s2", "1")
print("str="..str)
local str1 = string.unpack(">s2", str)
print("str1="..str1)

