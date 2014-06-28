local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function greetCallback(cid)
	local player = Player(cid)
	if player:getStorageValue(Storage.OutfitQuest.DruidHatAddon) < 9 then
		npcHandler:say("GRRRRRRRRRRRRR", cid)
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "addon") or msgcontains(msg, "outfit") then
		if player:getStorageValue(Storage.OutfitQuest.DruidHatAddon) == 9 then
			npcHandler:say("I can see in your eyes that you are a honest and friendly person, " .. player:getName() .. ". You were patient enough to learn our language and I will grant you a special gift. Will you accept it?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then	
			npcHandler:say("From now on, you shall be known as " .. player:getName() .. ", the bear warrior. You shall be strong and proud as Angros, the great dark bear. He shall guide your path.", cid)
			player:setStorageValue(Storage.OutfitQuest.DruidHatAddon, 10)
			player:addOutfitAddon(148, 2)
			player:addOutfitAddon(144, 2)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end


npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
