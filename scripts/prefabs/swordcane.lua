local assets =
{
    Asset("ANIM", "anim/swordcane.zip"),
    Asset("ANIM", "anim/swap_swordcane.zip"),
    
    Asset("ATLAS", "images/inventoryimages/swordcane.xml"),
    Asset("IMAGE", "images/inventoryimages/swordcane.tex"),
}

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_swordcane", "swap_swordcane")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onattack_hum(inst, attacker, target, skipsanity)

    if inst.components.fueled:IsEmpty() then
        inst.components.weapon:SetDamage(TUNING.CANE_DAMAGE)
    else
        inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE)
    
        if attacker and attacker.components.sanity and not skipsanity then
            attacker.components.sanity:DoDelta(-TUNING.SANITY_SUPERTINY)
        end

        if target.components.burnable then
            if target.components.burnable:IsBurning() then
                target.components.burnable:Extinguish()
            elseif target.components.burnable:IsSmoldering() then
                target.components.burnable:SmotherSmolder()
            end
        end

        if target.components.freezable then
            target.components.freezable:AddColdness(1)
            target.components.freezable:SpawnShatterFX()
        end

        inst.components.fueled:DoDelta(-1)
    end
    
    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.combat then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.sg and not target.sg:HasStateTag("frozen") then
        target:PushEvent("attacked", {attacker = attacker, damage = 0})
    end

end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("swordcane")
    inst.AnimState:SetBuild("swordcane")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.CANE_DAMAGE)
    inst.components.weapon:SetOnAttack(onattack_hum)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "swordcane"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/swordcane.xml"
    inst.components.inventoryitem.keepondeath = true

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
    
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:InitializeFuelLevel(100)
    inst.components.fueled.accepting = true
    inst.components.fueled.ontakefuelfn = ontakefuel

    if not inst.components.characterspecific then
        inst:AddComponent("characterspecific")
    end
	
	inst.components.characterspecific:SetOwner("brook")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("Cold enough to sear flesh") 
    

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/swordcane", fn, assets)
