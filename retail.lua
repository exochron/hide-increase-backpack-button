
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
    C_CVar.SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_BAG_SLOTS_AUTHENTICATOR, true)
end)

hooksecurefunc("ContainerFrame_GenerateFrame", function(frame, _, id)
    if id == 0 and not IsAccountSecured() then
        local BACKPACK_DEFAULT_TOPHEIGHT = 256
        local BACKPACK_BASE_HEIGHT = 256
        local BACKPACK_MONEY_OFFSET_DEFAULT = -231

        local name = frame:GetName()
        local bgTextureTop = _G[name.."BackgroundTop"]
        bgTextureTop:SetHeight(BACKPACK_DEFAULT_TOPHEIGHT)
        bgTextureTop:SetTexCoord(0, 1, 0, 1)

        _G[name.."MoneyFrame"]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, BACKPACK_MONEY_OFFSET_DEFAULT)
        _G[name.."AddSlotsButton"]:Hide()

        _G[name.."BackgroundMiddle1"]:Hide()
        _G[name.."BackgroundMiddle2"]:Hide()
        _G[name.."BackgroundBottom"]:Hide()
        BACKPACK_HEIGHT = BACKPACK_BASE_HEIGHT
        frame:SetHeight(BACKPACK_HEIGHT)
        ManageBackpackTokenFrame(frame)

        _G[name.."Item1"]:Hide()
        _G[name.."Item2"]:Hide()
        _G[name.."Item3"]:Hide()
        _G[name.."Item4"]:Hide()
    end
end)
