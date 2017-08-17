local state = {}

local Text = require "text"

local function drawStar(x, y, f)
	local star = {
		x,y-7,
		x+1,y-2,
		x+7,y-2,
		x+3,y,
		x+4,y+6,
		x,y+3,
		x-4,y+6,
		x-3,y,
		x-7,y-2,
		x-1,y-2
	}
	local triangles = love.math.triangulate(star)
	if f then
		for i,v in ipairs(triangles) do
			lg.polygon("fill", v)
		end
	end
	lg.polygon("line", star)
end

local backdrop = lg.newImage("data/map.png")
local locations = require "data.locations"

local function updateui()
	interface:clear("loc")
	
	for i,v in ipairs(locations) do
		local w = lg.getFont():getWidth(v.name)
		interface:add("loc", Text(v.name, v.x-w/2, v.y+10, true, function() v.visited = not v.visited end))
	end
	
end

function state:init()
	updateui()
end

function state:update(dt)
	
end

function state:draw()
	lg.setColor(100, 100, 100)
	lg.draw(backdrop)
	lg.setColor(255,255,255)
	for i,v in ipairs(locations) do
		drawStar(v.x, v.y, v.visited)
	end
	interface:update("loc")
end

function state:mousepressed(x, y, b)
	interface:mousepressed("loc", x, y, b)
	
end

function state:mousereleased(x, y, b)
	
end

function state:keypressed(key)
	if key == 'z' then
		table.remove(locations, #locations)
	end
	if key == 'p' then
		local dump = '{'
		for i,v in ipairs(locations) do
			dump = dump .. '\n\t{\n'
			dump = dump .. '\t\t x=' .. v.x .. '\n'
			dump = dump .. '\t\t y=' .. v.y .. '\n'
			dump = dump .. '\t\t name=' .. v.name .. '\n'
			dump = dump .. '\t\t visited=' .. tostring(v.visited) .. '\n'
			dump = dump .. '\t}\n'
		end
		dump = dump .. '}'
		print(dump)
	end
end

function state:keyreleased(key)
	
end

return state