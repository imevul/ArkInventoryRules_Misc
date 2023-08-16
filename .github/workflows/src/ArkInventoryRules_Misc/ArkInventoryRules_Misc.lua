local rule = ArkInventoryRules:NewModule( "ArkInventoryRules_Misc" )
local VANILLA_MIN_ITEMID = 1
local TBC_MIN_ITEMID = 20000
local WOTLK_MIN_ITEMID = 30000

local function strSplit(inputStr, sep)
	if sep == nil then
		sep = "%s"
	end
	
	local t = {}
	for str in string.gmatch(inputStr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	
	return t
end

local function getInternalId()
	local internalId = ArkInventory.ObjectIDInternal( ArkInventoryRules.Object.h )
	return internalId
end

local function getItemId()
	local internalId = getInternalId()
	local itemId = select(2, unpack(strSplit(internalId, ":")))
	return tonumber(itemId)
end

function rule:OnEnable( )
	local registered = ArkInventoryRules.Register( self, "VANILLA", rule.vanilla ) and
		ArkInventoryRules.Register( self, "TBC", rule.tbc ) and
		ArkInventoryRules.Register( self, "WOTLK", rule.wotlk ) and
		ArkInventoryRules.Register( self, "EMPTY", rule.empty )
end

function rule.empty( ... )
	local fn = "EMPTY"

	local itemId = getItemId()
	return itemId == 0
end

function rule.vanilla( ... )
	local fn = "VANILLA"

	local itemId = getItemId()
	return itemId >= VANILLA_MIN_ITEMID and itemId < TBC_MIN_ITEMID
end

function rule.tbc( ... )
	local fn = "TBC"

	local itemId = getItemId()
	return itemId >= TBC_MIN_ITEMID and itemId < WOTLK_MIN_ITEMID
end

function rule.wotlk( ... )
	local fn = "WOTLK"

	local itemId = getItemId()
	return itemId >= WOTLK_MIN_ITEMID
end
