local util_msg = 10
local util_time = 8
local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1366, sy_/768
local msgutils = {}

function utilmsg(msg,r,g,b,sound,time)
	for index, util in ipairs (msgutils) do
		if (#msgutils >= 10) then return end
		if (util.msgutil == msg) then return end
	end
	if (not msg) then 
		return false 
	end
	local r, g, b = r or 255, g or 255, b or 255
	local time = tonumber (time) or util_time
	local util = { 
		msgutil = msg,
		r = r,
		g = g,
		b = b,
		alphaEnter = 0,
		ut_lock = true,
		tickCount = getTickCount() + (time*1000)
	}
	table.insert (msgutils,util)
	if sound then
		playSoundFrontEnd (sound)
	end
end 
addEvent(getResourceName(getThisResource())..":utilmsg",true)
addEventHandler(getResourceName(getThisResource())..":utilmsg",root,utilmsg)

function removeColorCoding( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end


function dxutil_message()
	local util_re = { 
		top = {}, 
		uti_data = {} 
	}
	for index, util in pairs (msgutils) do
		if (not util.ut_lock) then
			if (util.alphaEnter > 6) then
				util.alphaEnter = util.alphaEnter - 6
			else
				util.alphaEnter = 0
			end
			if ( util.alphaEnter <= 20) then
				table.insert (util_re.uti_data, index)
			end
			msgutils[index].alphaEnter = util.alphaEnter
		else
			if ( util.alphaEnter < 250 ) then
				util.alphaEnter = util.alphaEnter + 12
				msgutils[index].alphaEnter = util.alphaEnter
			end
		end
		if (util.tickCount <= getTickCount()) then
			util.ut_lock = false
			msgutils[index].ut_lock=false
		end
		dxDrawText(removeColorCoding(tostring ( util.msgutil )), 15 - 1, 551*sy+(index*22) - 1, sx_ - 1, 100*sy+((index-1)*22) - 1, tocolor(0, 0, 0, util.alphaEnter), 1.00, "default-bold", "left", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( util.msgutil )), 15 + 1, 551*sy+(index*22) - 1, sx_ + 1, 100*sy+((index-1)*22) - 1, tocolor(0, 0, 0, util.alphaEnter), 1.00, "default-bold", "left", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( util.msgutil )), 15 - 1, 551*sy+(index*22) + 1, sx_ - 1, 100*sy+((index-1)*22) + 1, tocolor(0, 0, 0, util.alphaEnter), 1.00, "default-bold", "left", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( util.msgutil )), 15 + 1, 551*sy+(index*22) + 1, sx_ + 1, 100*sy+((index-1)*22) + 1, tocolor(0, 0, 0, util.alphaEnter), 1.00, "default-bold", "left", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( util.msgutil )), 15, 551*sy+(index*22), sx_, 100*sy+((index-1)*22), tocolor(util.r, util.g, util.b, util.alphaEnter), 1.00, "default-bold", "left", "center", false, false, false, false, false)
	end 
	if (#msgutils > util_msg and msgutils[1].ut_lock) then
		msgutils[1].ut_lock = false
	end 
	if (#util_re.uti_data > 0) then
		for index, data in pairs (util_re.uti_data) do
			table.remove (msgutils,data)
		end
	end
end
addEventHandler("onClientRender",root,dxutil_message)
