
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/brook.zip" ),
        Asset( "ANIM", "anim/ghost_brook_build.zip" ),
}
local prefabs = {
}

-- Custom starting items
local start_inv = {
    "swordcane",
    "violin",
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

local function sanityfn(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local delta = 0
    local max_rad = 10
    local ents = TheSim:FindEntities(x, y, z, max_rad, { "player" }, { "playerghost" })
    for i, v in ipairs(ents) do
        delta = delta + TUNING.SANITYAURA_SMALL_TINY
    end
    -- remove for brook
    delta = delta - TUNING.SANITYAURA_SMALL_TINY
    -- brook is alone
    if (delta == 0) then
        delta = delta - TUNING.SANITYAURA_TINY
    end
    return delta
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "brook.tex" )
        -- character tags
    inst:AddTag("deadbones")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "woodie"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(175)
	inst.components.sanity:SetMax(125)
    inst.components.sanity.custom_rate_fn = sanityfn

    -- Food heals halved
    local _Eat = inst.components.eater.Eat
    function inst.components.eater:Eat( food )
        if food.components.edible.healthvalue > 2 then
            food.components.edible.healthvalue = food.components.edible.healthvalue/2
        end
        return _Eat( self, food )
    end

    -- Insulated from temp changes
    inst.components.temperature.inherentinsulation = 120
    inst.components.temperature.inherentsummerinsulation = -120
    
    -- Can play violin
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 0
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("brook", prefabs, assets, common_postinit, master_postinit, start_inv)
