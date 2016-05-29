local assets =
{
    Asset("ANIM", "anim/violin.zip"),
    Asset("ANIM", "anim/swap_violin.zip"),
    
    Asset("ATLAS", "images/inventoryimages/violin.xml"),
    Asset("IMAGE", "images/inventoryimages/violin.tex"),
}

local function playviolin(inst, owner)
    if (owner.components.sanity and owner.components.sanity.current < owner.components.sanity.max)
    and (owner.components.hunger and owner.components.hunger.current) then
        owner.components.hunger:DoDelta(-TUNING.REDAMULET_CONVERSION)
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_violin", "swap_violin")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if (owner.components.sanityaura) then
        owner.components.sanityaura.aura = TUNING.SANITYAURA_TINY
    end
    inst.task = inst:DoPeriodicTask(15, playviolin, nil, owner)
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if (owner.components.sanityaura) then
        owner.components.sanityaura.aura = 0
    end
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

    inst.AnimState:SetBank("violin")
    inst.AnimState:SetBuild("violin")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

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
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/violin", fn, assets)
