local name = getResourceName ( getThisResource ( ) )
function sendMessage ( msg, player, r, g, b, time )
	if ( msg and player ) then
		if ( isElement ( player ) ) then
			triggerClientEvent ( player, name..":sendMessage", player, msg, r, g, b, time )
			return true
		else return false end
	else return false end
end

function trashDo ( msg, player, r, g, b, time )
	if ( msg and player ) then
		if ( isElement ( player ) ) then
			triggerClientEvent ( player, name..":trashDo", player, msg, r, g, b, time )
			return true
		else return false end
	else return false end
end

function utilmsg ( msg, player, r, g, b, time )
	if ( msg and player ) then
		if ( isElement ( player ) ) then
			triggerClientEvent ( player, name..":utilmsg", player, msg, r, g, b, time )
			return true
		else return false end
	else return false end
end

function trashLast( msg, player, r, g, b, time )
	if ( msg and player ) then
		if ( isElement ( player ) ) then
			triggerClientEvent ( player, name..":trashLast", player, msg, r, g, b, time )
			return true
		else return false end
	else return false end
end