local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
    C_CVar.SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_BAG_SLOTS_AUTHENTICATOR, true)
end)

ContainerFrame1.GetRows = function()
    return IsAccountSecured() and 5 or 4
end

local function SortItemsByExtendedState(item1, item2)
    local extended1, extended2 = item1:IsExtended(), item2:IsExtended();
    if extended1 ~= extended2 then
        return not extended1;
    end

    local bag1, bag2 = item1:GetBagID(), item2:GetBagID();
    if bag1 ~= bag2 then
        return bag1 > bag2;
    end

    local id1, id2 = item1:GetID(), item2:GetID();
    return id1 < id2;
end

local function CollectItems(self)
    local itemsToLayout = {};
    for _, itemButton in self:EnumerateValidItems() do
        if not itemButton.isExtended then
            table.insert(itemsToLayout, itemButton);
        end
    end

    return itemsToLayout
end

hooksecurefunc(ContainerFrame1, "UpdateItemLayout", function(self)
    AnchorUtil.GridLayout(CollectItems(self), self:GetInitialItemAnchor(), self:GetAnchorLayout())
end)
hooksecurefunc(ContainerFrameCombinedBags, "UpdateItemLayout", function(self)
    local items = CollectItems(self)
    table.sort(items, SortItemsByExtendedState)
    AnchorUtil.GridLayout(items, self:GetInitialItemAnchor(), self:GetAnchorLayout())
end)
hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, _, id)
    if id == 0 and not IsAccountSecured() then
        frame.AddSlotsButton:Hide()
        ContainerFrame1Item1:Hide()
        ContainerFrame1Item2:Hide()
        ContainerFrame1Item3:Hide()
        ContainerFrame1Item4:Hide()
    end
end)
