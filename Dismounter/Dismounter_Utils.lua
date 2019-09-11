local addonName, addon = ...

addon.utils = {};

local UI_ERROR_MESSAGES_FOR_MOUNTED = { 50, 198, 213, 504 };

addon.utils.findInArray = function(array, valueToFind)
    local found = false;

    for i, value in pairs(array) do
        if value == valueToFind then
            found = true;
            break;
        end
    end

    return found;
end

addon.utils.isMountErrorMessage = function(id)
    return addon.utils.findInArray(UI_ERROR_MESSAGES_FOR_MOUNTED, id);
end
