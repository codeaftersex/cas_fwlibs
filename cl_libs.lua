MBLFunctions = {}
CASFWlibsClientLoaded = false
-- things that are not in the default lua libraries
CreateThread(function()
    local vorpDedected = GetResourceState('vorp_core') == 'started'
    print("Vorp: " .. tostring(vorpDedected))
    if vorpDedected then
        VorpCore = exports.vorp_core:GetCore()
        MBLFunctions["notify"] = function(text, duration)
            return exports['cas-simplenotify']:showNotification(text, duration)
        end
        CASFWlibsClientLoaded = true
    end
    local rsgDedected = GetResourceState('rsg-core') == 'started'
    if rsgDedected then
        print("RSG: " .. tostring(rsgDedected))
        RSGCore = exports['rsg-core']:GetCoreObject()
        MBLFunctions["notify"] = function(text,duration)
            return exports['cas-simplenotify']:showNotification(text, duration)
        end
        CASFWlibsClientLoaded = true
    end


    local tpzcoreDetected = GetResourceState('tpz_core') == 'started'
    if tpzcoreDetected then

        print("TPZ-CORE: " .. tostring(tpzcoreDetected))
        TPZ = exports.tpz_core:getCoreAPI()

        MBLFunctions["notify"] = function(text, duration)
            return exports['cas-simplenotify']:showNotification(text, duration)
        end

        CASFWlibsClientLoaded = true
    end
        
end)

exports("MBLFunctions", function()
    while not CASFWlibsClientLoaded do Wait(0) end
    return MBLFunctions
end)