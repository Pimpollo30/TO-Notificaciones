local whatMsg = 10
local whatTime = 8
local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1366, sy_/768
local messages = {}

function sendMessage(msg,r,g,b,sound,time)
	for index,data in ipairs (messages) do
		if (#messages >= 10) then return end
		if (data.message == msg) then return end
	end
	if (not msg) then 
		return false 
	end
	local r, g, b = r or 255, g or 255, b or 255
	local time = tonumber (time) or whatTime
	local data = { 
		message = msg,
		r = r,
		g = g,
		b = b,
		alphaEnter = 0,
		alphaDraw = 0,
		whatLock = true,
		tickCount = getTickCount() + (time*1000)
	}
	table.insert (messages,data)
	if sound then
		playSoundFrontEnd (sound)
	end
end
addEvent(getResourceName(getThisResource())..":sendMessage",true)
addEventHandler(getResourceName(getThisResource())..":sendMessage",root,sendMessage)

function removeColorCoding( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end


function dxMessage()
	local removeData = { 
		top = {}, 
		whatData = {} 
	}
	for index, data in pairs (messages) do
		if (not data.whatLock) then
			if (data.alphaEnter > 6) then
				data.alphaEnter = data.alphaEnter - 6
			else
				data.alphaEnter = 0
			end
			if (data.alphaDraw > 6) then
				data.alphaDraw = data.alphaDraw - 6
			else
				data.alphaDraw = 0
			end
			if ( data.alphaEnter <= 20) then
				table.insert (removeData.whatData, index)
			end
			messages[index].alphaEnter = data.alphaEnter
			messages[index].alphaDraw = data.alphaDraw
		else
			if ( data.alphaEnter < 250 ) then
				data.alphaEnter = data.alphaEnter + 12
				messages[index].alphaEnter = data.alphaEnter
			end
			if ( data.alphaDraw < 170 ) then
				data.alphaDraw = data.alphaDraw + 12
				messages[index].alphaDraw = data.alphaDraw
			end
		end 
		if (data.tickCount <= getTickCount()) then
			data.whatLock = false
			messages[index].whatLock = false
		end
		dxDrawRectangle((sx_/2-1366/2.73), sy_-(index*23), 1000, 23, tocolor(0, 0, 0, data.alphaDraw), false)
		dxDrawText(removeColorCoding(tostring ( data.message )), 0 - 1, sy_-(index*23) - 1, sx_ - 1, sy_-((index-1)*23) - 1, tocolor(0, 0, 0, data.alphaEnter), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( data.message )), 0 + 1, sy_-(index*23) - 1, sx_ + 1, sy_-((index-1)*23) - 1, tocolor(0, 0, 0, data.alphaEnter), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( data.message )), 0 - 1, sy_-(index*23) + 1, sx_ - 1, sy_-((index-1)*23) + 1, tocolor(0, 0, 0, data.alphaEnter), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( data.message )), 0 + 1, sy_-(index*23) + 1, sx_ + 1, sy_-((index-1)*23) + 1, tocolor(0, 0, 0, data.alphaEnter), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText(removeColorCoding(tostring ( data.message )), 0, sy_-(index*23), sx_, sy_-((index-1)*23), tocolor(data.r, data.g, data.b, data.alphaEnter), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	end 
	if (#messages > whatMsg and messages[1].whatLock) then
		messages[1].whatLock = false
	end 
	if (#removeData.whatData > 0) then
		for index, data in pairs (removeData.whatData) do
			table.remove (messages,data)
		end
	end
end
addEventHandler("onClientRender",root,dxMessage)