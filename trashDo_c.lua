local do_msg = 7
local do_time = 8
local sW,sH = guiGetScreenSize()


local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1366, sy_/768
local msgdo = {}

function trashDo(msg,r,g,b,sound,time)
	for index,does in ipairs (msgdo) do
		if (#msgdo >= 7) then return end
		if (does.msgdo == msg) then return end
	end
	if (not msg) then 
		return false 
	end
	local r, g, b = r or 255, g or 255, b or 255
	local time = tonumber (time) or do_time
	local does = { 
		msgdo = msg,
		r = r,
		g = g,
		b = b,
		alphaEnter = 0,
		do_lock = true,
		tickCount = getTickCount() + (time*1000)
	}
	table.insert (msgdo,does)
	if sound then
		playSoundFrontEnd (sound)
	end
end 
addEvent(getResourceName(getThisResource())..":trashDo",true)
addEventHandler(getResourceName(getThisResource())..":trashDo",root,trashDo)

function removeColorCoding( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end


function do_message()
	local do_re = { 
		top = {}, 
		do_data = {} 
	}
	for index, does in pairs (msgdo) do
		if (not does.do_lock) then
			if (does.alphaEnter > 6) then
				does.alphaEnter = does.alphaEnter - 6
			else
				does.alphaEnter = 0
			end
			if ( does.alphaEnter <= 20) then
				table.insert (do_re.do_data, index)
			end
			msgdo[index].alphaEnter = does.alphaEnter
		else
			if ( does.alphaEnter < 250 ) then
				does.alphaEnter = does.alphaEnter + 12
				msgdo[index].alphaEnter = does.alphaEnter
			end
		end
		if (does.tickCount <= getTickCount()) then
			does.do_lock = false
			msgdo[index].do_lock=false
		end
		
		dxDrawText(removeColorCoding(tostring ( does.msgdo )), sW - 410 - 10-1 - 1, 440*sy+(index*22) - 1, (sW - 410 - 10) + 410- 1, 436*sy+((index-1)*22) - 1, tocolor(0, 0, 0, does.alphaEnter), 1.11, "default-bold", "right", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( does.msgdo )), sW - 410 - 10+1 + 1, 440*sy+(index*22) - 1, (sW - 410 - 10) + 410+ 1, 436*sy+((index-1)*22) - 1, tocolor(0, 0, 0, does.alphaEnter), 1.11, "default-bold", "right", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( does.msgdo )), sW - 410 - 10-1 - 1, 440*sy+(index*22) + 1, (sW - 410 - 10) + 410- 1, 436*sy+((index-1)*22) + 1, tocolor(0, 0, 0, does.alphaEnter), 1.11, "default-bold", "right", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( does.msgdo )), sW - 410 - 10+1 + 1, 440*sy+(index*22) + 1, (sW - 410 - 10) + 410+ 1, 436*sy+((index-1)*22) + 1, tocolor(0, 0, 0, does.alphaEnter), 1.11, "default-bold", "right", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( does.msgdo )), sW - 410 - 10, 440*sy+(index*22), (sW - 410 - 10) + 410, 436*sy+((index-1)*22), tocolor(does.r, does.g, does.b, does.alphaEnter), 1.11, "default-bold", "right", "center", false, false, false, false, false)
		
		
	end 
	if (#msgdo > do_msg and msgdo[1].do_lock) then
		msgdo[1].do_lock = false
	end 
	if (#do_re.do_data > 0) then
		for index, data in pairs (do_re.do_data) do
			table.remove (msgdo,data)
		end
	end
end
addEventHandler("onClientRender",root,do_message)
