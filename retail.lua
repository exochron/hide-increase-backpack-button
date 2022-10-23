local ITEM_SPACING_Y = 5;

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
    C_CVar.SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_BAG_SLOTS_AUTHENTICATOR, true)
end)

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
        if itemButton:IsExtended() then
            itemButton:Hide()
        else
            table.insert(itemsToLayout, itemButton);
        end
    end

    return itemsToLayout
end
local function UpdateItemLayout(self)
    if not IsAccountSecured() and not InCombatLockdown() then
        self.AddSlotsButton:Hide()
        local items = CollectItems(self)
        table.sort(items, SortItemsByExtendedState)
        AnchorUtil.GridLayout(items, self:GetInitialItemAnchor(), self:GetAnchorLayout())
    end
end
hooksecurefunc(ContainerFrame1, "UpdateItemLayout", UpdateItemLayout)
hooksecurefunc(ContainerFrameCombinedBags, "UpdateItemLayout", UpdateItemLayout)

hooksecurefunc(ContainerFrame1, "UpdateFrameSize", function(self)
    if not IsAccountSecured() and not InCombatLockdown() then
        local height = self:CalculateHeight()
        height = height - self.Items[1]:GetHeight() - ITEM_SPACING_Y
        self:SetSize(self:CalculateWidth(), height)
    end
end)
hooksecurefunc(ContainerFrameCombinedBags, "UpdateFrameSize", function(self)
    if not IsAccountSecured() and not InCombatLockdown() then
        local rows = math.ceil((self:GetBagSize() - 4) / self:GetColumns())
        if rows < self:GetRows() then
            local itemsHeight = (rows * self.Items[1]:GetHeight()) + ((rows - 1) * ITEM_SPACING_Y);
            local height = itemsHeight + self:GetPaddingHeight() + self:CalculateExtraHeight();

            self:SetSize(self:CalculateWidth(), height)
        end
    end
end)