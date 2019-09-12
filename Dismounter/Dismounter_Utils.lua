local addonName, addon = ...

local UI_ERROR_MESSAGES_FOR_MOUNTED = { 
    ERR_ATTACK_MOUNTED,
    ERR_NOT_WHILE_MOUNTED,
    SPELL_FAILED_NOT_MOUNTED
};

addon.utils = {};

addon.utils.isMountErrorMessage = function(msg)
    return tContains(UI_ERROR_MESSAGES_FOR_MOUNTED, msg);
end
