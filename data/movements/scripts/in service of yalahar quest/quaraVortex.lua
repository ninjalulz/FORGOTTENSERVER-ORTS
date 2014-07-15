function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end
	
	local headItem = player:getSlotItem(CONST_SLOT_HEAD)	
	if headItem and isInArray({5461, 12541, 15408}, headItem:getId()) then 
		player:teleportTo(Position(32950, 31181, 9))
		player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
		player:say("The vortex throws you out in this vicious place.", TALKTYPE_MONSTER_SAY)
	else
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wear an underwater exploration helmet in order to dive.")
	end
	return true
end
