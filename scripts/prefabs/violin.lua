local assets =
{
    Asset("ANIM", "anim/swordcane.zip"),
    Asset("ANIM", "anim/swap_swordcane.zip"),
    
    Asset("ATLAS", "images/inventoryimages/violin.xml"),
    Asset("IMAGE", "images/inventoryimages/violin.tex"),
}

local function playviolin(inst, owner)
    if (owner.components.sanity and owner.components.sanity.current < owner.components.sanity.max)
    and (owner.components.hunger and owner.components.hunger.current > 5) then
        owner.components.sanity:DoDelta(TUNING.REDAMULET_CONVERSION,false,"violin")
        owner.components.hunger:DoDelta(-TUNING.REDAMULET_CONVERSION)
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_swordcane", "swap_swordcane")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY
    inst.task = inst:DoPeriodicTask(20, playviolin, nil, owner)
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    inst.components.sanityaura.aura = 0
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
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

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 0
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.CANE_DAMAGE)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "violin"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/violin.xml"
    inst.components.inventoryitem.keepondeath = true

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 0.5

    MakeHauntableLaunch(inst)
    
    if not inst.components.characterspecific then
        inst:AddComponent("characterspecific")
    end
	
	inst.components.characterspecific:SetOwner("brook")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("It looks like it goes out of tune easily")

    return inst
end

return Prefab("common/inventory/violin", fn, assets)
