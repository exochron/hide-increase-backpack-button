-- see https://github.com/tomrus88/BlizzardInterfaceCode/blob/classic/Interface/FrameXML/ContainerFrame.lua#L31

if not InCombatLockdown() then
    ContainerFrame1AddSlotsButton:Hide()
end
hooksecurefunc(ContainerFrame1AddSlotsButton, "SetShown", function(self, show)
    if show and not InCombatLockdown() then
        self:Hide()
    end
end)