local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1366, sy_/768
local msgTrash = {}

trash_time = 8000

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function trashLast(msg,r,g,b,sound,time)
    if (not msg) then 
        return false 
    end
    if isTimer(timerKillingUP) then
        killTimer(timerKillingUP)
    end
    if isEventHandlerAdded("onClientRender",root,dxutil_trashJoins) then
        removeEventHandler("onClientRender",root,dxutil_trashJoins)
    end
    
    addEventHandler("onClientRender",root,dxutil_trashJoins)
    local r, g, b = r or 255, g or 255, b or 255
    local time = tonumber (time) or trash_time
    local trash = { 
        trashmsg = msg,
        r = r,
        g = g,
        b = b,
        alphaEnter = 0,
    }
    table.remove(msgTrash)
    table.insert (msgTrash,trash)
    timerKillingUP = setTimer(removeDataMessage,time,1)
    if sound then
        playSoundFrontEnd (sound)
    end
end 
addEvent(getResourceName(getThisResource())..":trashLast",true)
addEventHandler(getResourceName(getThisResource())..":trashLast",root,trashLast)

function removeColorCoding( name )
    return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

function getNames()
    local time = getRealTime()
    if (time.month == 0) then
        m = "Enero"
    elseif (time.month == 1) then
        m = "Febrero"
    elseif (time.month == 2) then
        m = "Marzo"
    elseif (time.month == 3) then
        m = "Abril"
    elseif (time.month == 4) then
        m = "Mayo"
    elseif (time.month == 5) then
        m = "Junio"
    elseif (time.month == 6) then
        m = "Julio"
    elseif (time.month == 7) then
        m = "Agosto"
    elseif (time.month == 8) then
        m = "Septiembre"
    elseif (time.month == 9) then
        m = "Octubre"
    elseif (time.month == 10) then
        m = "Noviembre"
    elseif (time.month == 11) then
        m = "Diciembre"
    end
    if (time.weekday == 0) then
        d = "Domingo"
    elseif (time.weekday == 1) then
        d = "Lunes"
    elseif (time.weekday == 2) then
        d = "Martes"
    elseif (time.weekday == 3) then
        d = "Miércoles"
    elseif (time.weekday == 4) then
        d = "Jueves"
    elseif (time.weekday == 5) then
        d = "Viernes"
    elseif (time.weekday == 6) then
        d = "Sábado"
    end
    return m,d
end



function removeDataMessage()
    local time = getRealTime()
    local year = string.format(" del %04d", time.year+1900)
    local day = string.format(" %02d de ", time.monthday)
    local month, wkday = getNames()
    for index, trash in pairs (msgTrash) do
        
        if (trash.trashmsg ~= wkday..""..day..""..month..""..year) then
            if isEventHandlerAdded("onClientRender",root,dxutil_trashJoins) then
                removeEventHandler("onClientRender",root,dxutil_trashJoins)
                table.remove(msgTrash)
            end
            local time = getRealTime()
            local year = string.format(" del %04d", time.year+1900)
            local day = string.format(" %02d de ", time.monthday)
            local month,wkday = getNames()
            
            exports["[TO]Notificaciones"]:trashLast(wkday..""..day..""..month..""..year,0,170,170)
        end
    end
end

function dxutil_trashJoins()
    for index, trash in pairs (msgTrash) do
        if ( trash.alphaEnter < 243 ) then
            trash.alphaEnter = trash.alphaEnter + 12
        else
            trash.alphaEnter = 255
        end
        
        dxDrawText(trash.trashmsg, 0*sx - 1, 0*sy - 1, 1366*sx - 1, 27*sy - 1, tocolor(0, 0, 0, trash.alphaEnter), 1.0, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(trash.trashmsg, 0*sx + 1, 0*sy - 1, 1366*sx + 1, 27*sy - 1, tocolor(0, 0, 0, trash.alphaEnter), 1.0, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(trash.trashmsg, 0*sx - 1, 0*sy + 1, 1366*sx - 1, 27*sy + 1, tocolor(0, 0, 0, trash.alphaEnter), 1.0, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(trash.trashmsg, 0*sx + 1, 0*sy + 1, 1366*sx + 1, 27*sy + 1, tocolor(0, 0, 0, trash.alphaEnter), 1.0, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(trash.trashmsg, 0*sx, 0*sy, 1366*sx, 27*sy, tocolor(trash.r, trash.g, trash.b, trash.alphaEnter), 1.0, "default-bold", "center", "center", false, false, false, false, false)
    end
end


rooting = getResourceRootElement(getThisResource())

function startingTrash()
    if isEventHandlerAdded("onClientRender",root,dxutil_trashJoins) then
        removeEventHandler("onClientRender",root,dxutil_trashJoins)
        table.remove(msgTrash)
    end
    local time = getRealTime()
    local year = string.format(" del %04d", time.year+1900)
    local day = string.format(" %02d de ", time.monthday)
    local month,wkday = getNames()
    
    exports["[TO]Notificaciones"]:trashLast(wkday..""..day..""..month..""..year,0,170,170)
end
addEventHandler ("onClientResourceStart",rooting,startingTrash)

