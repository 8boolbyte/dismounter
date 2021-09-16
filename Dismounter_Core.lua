local addonName, addon = ...

SLASH_DISMOUNTER1 = "/dismounter"

SlashCmdList.DISMOUNTER = function(msg, editBox)
    local option1 = strsplit("", msg)
    if #option1 > 0 then
        if option1 == "info" then
            addon.utils.printMsg("Dismounter TBC is a simple addon that will automatically dismounts you when you perform an action that needs you to be dismounted. It will also remove ghost wolf when an error occurs and while you're not in combat. The option 'flying' will influence if Dismounter will dismount you while flying or not.")
        end
        if option1 == "flying" then
            if(DismounterDB.flying == 0) then
                DismounterDB.flying = 1
                addon.utils.printMsg("Dismounting while flying is enabled.")
            else
                DismounterDB.flying = 0
                addon.utils.printMsg("Dismounting while flying is disabled.")
            end
        end
    else
        addon.utils.printMsg("available commands are\ninfo - Display info about Dismounter\nflying - Enable or disable dismounting while flying")
    end
end

local function addEventListeners(self)
    addon.core.frame:RegisterEvent("ADDON_LOADED")
    addon.core.frame:RegisterEvent("UI_ERROR_MESSAGE")
    addon.core.frame:RegisterEvent("TAXIMAP_OPENED")
end

local function onEvent(self, event, ...)
    local args = {...}
    
    if event == "ADDON_LOADED" then
        DismounterDB = DismounterDB or {}
        DismounterDB.flying = (DismounterDB.flying or 1)
    end

    if event == "UI_ERROR_MESSAGE" then

        local msg = args[2];

        local isMountErrorMessage = addon.utils.isMountErrorMessage(msg);
        local isShapeshiftErrorMessage = addon.utils.isShapeshiftErrorMessage(msg);

        if (isMountErrorMessage) then
            if DismounterDB.flying == 1 then
                UIErrorsFrame:Clear();
                Dismount();
            else
                if IsFlying() then
                    UIErrorsFrame:Clear();
                else
                    UIErrorsFrame:Clear();
                    Dismount();
                end
            end
        end

        if (isShapeshiftErrorMessage) then
            if (InCombatLockdown()) then
                addon.utils.printMsg("Can't remove Spirit Wolf in combat.")
            else
                if (addon.utils.cancelShapeshiftBuffs()) then
                    UIErrorsFrame:Clear();
                end
            end
        end;

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

    addon.utils.printMsg("loaded DEV version");
end

init();