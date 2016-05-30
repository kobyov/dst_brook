local assets =
{
    Asset("ANIM", "anim/violin.zip"),
    Asset("ANIM", "anim/swap_violin.zip"),
    
    Asset("ATLAS", "images/inventoryimages/violin.xml"),
    Asset("IMAGE", "images/inventoryimages/violin.tex"),
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_violin", "swap_violin")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if (owner.components.sanityaura) then
        owner.components.sanityaura.aura = TUNING.SANITYAURA_HUGE
    end
    inst.components.fueled:StartConsuming()
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if (owner.components.sanityaura) then
        owner.components.sanityaura.aura = 0
    end
    inst.components.fueled:StopConsuming()
end

local function violin_perish(inst)
    inst:Remove()
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

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.ONEMANBAND
    inst.components.fueled:InitializeFuelLevel(TUNING.ONEMANBAND_PERISHTIME)
    inst.components.fueled:SetDepletedFn(violin_perish)

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 0.5
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_HUGE

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/violin", fn, assets)
