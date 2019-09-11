local addonName, addon = ...

local function addEventListeners(self)
    addon.core.frame:RegisterEvent("UI_ERROR_MESSAGE")
end

local function onEvent(self, event, ...)
    local args = {...}

    if event == "ADDON_LOADED" then
        addEventListeners();
        return;
    end
    
    if event == "UI_ERROR_MESSAGE" then
        local isMountErrorMessage = addon.utils.isMountErrorMessage(args[1]);

        if (isMountErrorMessage) then
            UIErrorsFrame:Clear();
            Dismount();
        end

        return
    end

end

local function init()
    addon.core = {};
    addon.core.frame = CreateFrame("Frame");
    addon.core.frame:RegisterEvent("ADDON_LOADED");
    addon.core.frame:SetScript("OnEvent", onEvent);
end

init();
