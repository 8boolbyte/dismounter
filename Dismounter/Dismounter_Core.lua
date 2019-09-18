local addonName, addon = ...

local function addEventListeners(self)
    addon.core.frame:RegisterEvent("UI_ERROR_MESSAGE")
    addon.core.frame:RegisterEvent("TAXIMAP_OPENED")
end

local function onEvent(self, event, ...)
    local args = {...}
    
    if event == "UI_ERROR_MESSAGE" then
        local isMountErrorMessage = addon.utils.isMountErrorMessage(args[2]);

        if (isMountErrorMessage) then
            UIErrorsFrame:Clear();
            addon.utils.cancelShapeshiftBuffs();
            Dismount();
        end

        return;
    end

    if event == "TAXIMAP_OPENED" then
        addon.utils.cancelShapeshiftBuffs();
        Dismount();
        return;
    end
end

local function init()
    addon.core = {};
    addon.core.frame = CreateFrame("Frame");
    addon.core.frame:SetScript("OnEvent", onEvent);
    addEventListeners();
end

init();
