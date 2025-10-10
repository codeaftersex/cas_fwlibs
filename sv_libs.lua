MBLFunctions = {}
local CASFWLibs = false
local usingVorp = GetResourceState("vorp_core") == "started"
print("^5 [Code After S*x FW Libs] | ^0 Vorp: " .. tostring(usingVorp))
if usingVorp then
    VorpCore = exports["vorp_core"]:GetCore()
    MBLFunctions["getMoney"] = function(source)
        local user = VorpCore.getUser(source)
        if not user then return end
        local character = user.getUsedCharacter
        return character.money or 0
    end
    
    MBLFunctions["AddItem"] = function(source, item, amount) 
        return exports.vorp_inventory:addItem(source, item, amount)
    end
    MBLFunctions["RemoveItem"] = function(source, item, amount)
        return exports.vorp_inventory:subItem(source, item, amount)
    end
    MBLFunctions["addWeapon"] = function(source, weapon, ammo, components, comps)
        if not ammo then ammo = 0 end
        if not components then components = {} end
        if not comps then comps = {} end
        if not weapon then print("Weapon name is required") return end
        print("Adding weapon: " .. weapon)
        exports.vorp_inventory:createWeapon(source, weapon)
        return true
    end
    MBLFunctions["removeWeapon"] = function(source, weaponId)
        return exports.vorp_inventory:subWeapon(source, weaponId)
    end
    MBLFunctions["canCarryItem"] = function(source, item, count)
        local canCarry = exports.vorp_inventory:canCarryItem(source, item, count)
        return canCarry
    end
    MBLFunctions["canCarryWeapons"] = function(source, weapon, count)
        if not count then count = 1 end
        local canCarry = exports.vorp_inventory:canCarryWeapons(source, count, false, weapon)
        return canCarry
    end
    MBLFunctions["getItemByName"] = function(source, item)
        local item = exports.vorp_inventory:getItemByName(source, item)
        return item
    end
    MBLFunctions["getInventory"] = function(source)
        local inv = exports.vorp_inventory:getUserInventoryItems(source)
        return inv
    end
    MBLFunctions["getItemCount"] = function(source, item)
        local promise = promise:new()
        exports.vorp_inventory:getItemCount(source, function(result)
            promise:resolve(result)
        end, item)
        return Citizen.Await(promise)
    end
    MBLFunctions["getItem"] = function(source, item)
        local promise = promise:new()
        exports.vorp_inventory:getItem(source, item, function(result)
            promise:resolve(result)
        end)
        return Citizen.Await(promise)
    end
    MBLFunctions["notify"] = function(source, message, duration)
        return TriggerClientEvent("notify:show", source, { text = message, duration = duration })
    end
    MBLFunctions["getPlayer"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character
    end
    MBLFunctions["getIdentifier"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.charIdentifier
    end
    MBLFunctions["getGroup"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        return user.getGroup
    end
    -- job
    MBLFunctions["getJob"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.job
    end
    --@jobgrade
    MBLFunctions["getJobGrade"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.jobGrade
    end
    -- gold
    MBLFunctions["getGold"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.gold or 0
    end
    --rol
    MBLFunctions["getRol"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.rol
    end
    -- firstname
    MBLFunctions["getFirstname"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.firstname
    end
    -- lastname
    MBLFunctions["getLastname"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.lastname
    end
    -- fullname
    MBLFunctions["getFullname"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.firstname .. " " .. character.lastname
    end
    --isDead 
    MBLFunctions["isdead"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return user.isdead
    end
    --age
    MBLFunctions["getAge"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.age
    end
    --gender
    MBLFunctions["getGender"] = function(source)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.gender
    end
    --getuserbycid
    MBLFunctions["getUserByCid"] = function(cid)
        local user = VorpCore.getUserByCharId(cid) --[[@as User]]  
        if not user then return end -- is player in session?
        return user
    end
    --SetJob
    
    MBLFunctions["setJob"] = function(source, job, grade)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.setJob(job, false)
    end
    --SetJobGrade
    MBLFunctions["setJobGrade"] = function(source, grade)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.setJobGrade(grade, false)
    end
    --setgroup
    MBLFunctions["setGroup"] = function(source, group)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.setGroup(group, false)
    end
    --setrol
    MBLFunctions["setRol"] = function(source, rol)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        return character.setRol(rol)
    end
    --addcurrency
    MBLFunctions["addCurrency"] = function(source, currency, amount)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        --The currency type (0 = money, 1 = gold, 2 = rol)
        character.addCurrency(currency, amount)
        return true
    end
    MBLFunctions["removeCurrency"] = function(source, currency, amount)
        local user = VorpCore.getUser(source) --[[@as User]]  
        if not user then return end -- is player in session?
        local character = user.getUsedCharacter --[[@as Character]]
        --The currency type (0 = money, 1 = gold, 2 = rol)
        character.removeCurrency(currency, amount)
        return true
    end
    CASFWLibs = true
end
local usingRSG = GetResourceState("rsg-core") == "started"
if usingRSG then
    print("[Code After S*x FW Libs] | RSG: " .. tostring(usingRSG))
    local rsgInvState = GetResourceState("rsg-inventory") == "started"
    if not rsgInvState then print("rsg-inventory is not started") return end
    RSGCore = exports["rsg-core"]:GetCoreObject()
    RSGInv = exports["rsg-inventory"]
    MBLFunctions["getMoney"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        if not player then return end
        return player.PlayerData.money.cash or 0
    end
    MBLFunctions["AddItem"] = function(source, item, amount)
        return RSGInv:AddItem(source, item, amount)
    end
    MBLFunctions["RemoveItem"] = function(source, item, amount)
       return RSGInv:RemoveItem(source, item, amount)
    end
    MBLFunctions["addWeapon"] = function(source, weapon, ammo, components, comps)
        return RSGInv:AddItem(source, weapon, 1)
    end
    MBLFunctions["removeWeapon"] = function(source, weapon)
        return RSGInv:RemoveItem(source, weapon, 1)
    end
    MBLFunctions["canCarryItem"] = function(source, item, count)
        local canCarry = RSGInv:CanAddItem(source, item, count)
        return canCarry
    end
    MBLFunctions["canCarryWeapons"] = function(source, weapon)
        local canCarry = RSGInv:CanAddItem(source, weapon, 1)
        return canCarry
    end
    MBLFunctions["getItemByName"] = function(source, item)
        local item = RSGInv:GetItemByName(source, item)
        return item
    end
    MBLFunctions["getInventory"] = function(source)
        local Player = RSGCore.Functions.GetPlayer(source)
        if not Player then return end
        local items = Player.PlayerData.items
        return items
    end
    MBLFunctions["getItemCount"] = function(source, item)
        local count = RSGInv:GetItemCount(source, item)
        return count
    end
    MBLFunctions["getItem"] = function(source, item)
        local item = RSGInv:GetItemByName(source, item)
        return item
    end
    MBLFunctions["notify"] = function(source, message, duration)
        return TriggerClientEvent("notify:show", source, { text = message, duration = duration })
    end
    MBLFunctions["getPlayer"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player
    end
    MBLFunctions["getIdentifier"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.citizenid
    end
    MBLFunctions["getGroup"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.group
    end
    MBLFunctions["getJob"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.job.name
    end
    MBLFunctions["getJobGrade"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.job.grade
    end
    MBLFunctions["getGold"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.money.bank
    end
    MBLFunctions["getRol"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.rol
    end
    MBLFunctions["getFirstname"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.charinfo.firstname
    end
    MBLFunctions["getLastname"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.charinfo.lastname
    end
    MBLFunctions["getFullname"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    end
    MBLFunctions["isdead"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.metadata["isdead"]
    end
    MBLFunctions["getAge"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        local birthdate = player.PlayerData.charinfo.birthdate
        local year, month, day = birthdate:match("(%d+)-(%d+)-(%d+)")
        year = tonumber(year)
        month = tonumber(month)
        day = tonumber(day)
        local currentDate = os.date("*t")
        local currentYear = currentDate.year
        local currentMonth = currentDate.month
        local currentDay = currentDate.day
        local age = currentYear - year
        if currentMonth < month or (currentMonth == month and currentDay < day) then
            age = age - 1
        end
        return age
    end
    MBLFunctions["getGender"] = function(source)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.PlayerData.charinfo.gender
    end
    MBLFunctions["getUserByCid"] = function(cid)
        local player = RSGCore.Functions.GetPlayerByCitizenId(cid)
        return player
    end
    MBLFunctions["setJob"] = function(source, job, grade)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.Functions.SetJob(job, grade)
    end
    MBLFunctions["setJobGrade"] = function(source, grade)
        local player = RSGCore.Functions.GetPlayer(source)
        local currentJob = player.PlayerData.job.name
        return player.Functions.SetJob(currentJob, grade)
    end
    MBLFunctions["setGroup"] = function(source, group)
        local Player = RSGCore.Functions.GetPlayer(playerId)
        local permission = group
        return RSGCore.Functions.AddPermission(Player.PlayerData.source, permission)
    end
    MBLFunctions["setRol"] = function(source, rol)
        local player = RSGCore.Functions.GetPlayer(source)
        return player.Functions.SetRol(rol)
    end
    MBLFunctions["addCurrency"] = function(source, currency, amount)
        local player = RSGCore.Functions.GetPlayer(source)
        currency = currency == 0 and "cash" or currency == 1 and "bank" or "black_money"
        return player.Functions.AddMoney(currency, amount)
    end
    MBLFunctions["removeCurrency"] = function(source, currency, amount)
        local player = RSGCore.Functions.GetPlayer(source)
        currency = currency == 0 and "cash" or currency == 1 and "bank" or "black_money"
        return player.Functions.RemoveMoney(currency, amount)
    end
    CASFWLibs = true
end 

local usingTPZCore = GetResourceState("tpz_core") == "started"
print("^5 [Code After S*x FW Libs] | ^0 TPZ-CORE: " .. tostring(usingTPZCore))

if usingTPZCore then

    TPZ = exports.tpz_core:getCoreAPI()

    MBLFunctions["getMoney"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)

        if not xPlayer.loaded() then return end
        return xPlayer.getAccount(0)
    end
    
    MBLFunctions["AddItem"] = function(source, item, amount) 
        local xPlayer = TPZ.GetPlayer(source)
        return xPlayer.addItem(item, amount) -- extra parameter to use metadata after amount is also available.
    end

    MBLFunctions["RemoveItem"] = function(source, item, amount)
        local xPlayer = TPZ.GetPlayer(source)

        return xPlayer.removeItem(item, amount)
    end

    MBLFunctions["addWeapon"] = function(source, weapon, ammo, components, comps)

        if not weapon then print("Weapon name is required") return false end

        local metadata = nil

        if ammo then
            metadata = {}
            metadata.ammo = ammo
        end

        if components then
            metadata.components = components
        end

        local xPlayer = TPZ.GetPlayer(source)
        xPlayer.addWeapon(weapon, weaponId, metadata)
        return true
    end

    MBLFunctions["removeWeapon"] = function(source, weaponId)
        local xPlayer = TPZ.GetPlayer(source)
        xPlayer.removeWeaponById(weaponId)
    end

    MBLFunctions["canCarryItem"] = function(source, item, count)
        local xPlayer      = TPZ.GetPlayer(source)
        local canCarryItem = xPlayer.canCarryItem(source, item, count)

        return canCarryItem
    end

    MBLFunctions["canCarryWeapons"] = function(source, weapon, count)
        local xPlayer        = TPZ.GetPlayer(source)
        local canCarryWeapon = xPlayer.canCarryWeapon(source, weapon) -- count always 1
        return canCarryWeapon
    end

    MBLFunctions["getItemByName"] = function(source, item)
        local item = exports.tpz_inventory:getInventoryAPI().getItemData(item) -- returns item data?
        return item
    end

    MBLFunctions["getInventory"] = function(source)
        local xPlayer  = TPZ.GetPlayer(source)
        local contents = xPlayer.getInventoryContents()
        return contents
    end

    MBLFunctions["getItemCount"] = function(source, item)
        local xPlayer      = TPZ.GetPlayer(source)
        local itemQuantity = xPlayer.getItemQuantity(item)
        return itemQuantity
    end

    MBLFunctions["getItem"] = function(source, item)
        local item = exports.tpz_inventory:getInventoryAPI().getItemData(item) -- returns item data?
        return item
    end

    MBLFunctions["notify"] = function(source, message, duration)
        return TriggerClientEvent("notify:show", source, { text = message, duration = duration })
    end
    
    MBLFunctions["getPlayer"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer
    end

    MBLFunctions["getIdentifier"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getIdentifier()
    end

    MBLFunctions["getGroup"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getGroup()
    end

    -- job
    MBLFunctions["getJob"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getJob()
    end

    --@jobgrade
    MBLFunctions["getJobGrade"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getJobGrade()
    end
    
    -- gold
    MBLFunctions["getGold"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return 0 end -- is player in session?
        return xPlayer.getAccount(1)
    end

    --rol
    MBLFunctions["getRol"] = function(source)
        -- n/a
        return 0
    end

    -- firstname
    MBLFunctions["getFirstname"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getFirstName()
    end
    -- lastname
    MBLFunctions["getLastname"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getLastName()
    end
    -- fullname
    MBLFunctions["getFullname"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getFirstName() .. ' ' .. xPlayer.getLastName()
    end

    --isDead 
    MBLFunctions["isdead"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.isDead()
    end

    --age
    MBLFunctions["getAge"] = function(source)
        return 0
    end
    
    --gender
    MBLFunctions["getGender"] = function(source)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.getGender()
    end

    --getuserbycid
    MBLFunctions["getUserByCid"] = function(cid)
        -- n/a
        return nil
    end
    --SetJob
    
    MBLFunctions["setJob"] = function(source, job, grade)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?

        xPlayer.setJob(job)

        if grade then
            xPlayer.setJobGrade(grade)
        end

        return true
    end

    --SetJobGrade
    MBLFunctions["setJobGrade"] = function(source, grade)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return  xPlayer.setJobGrade(grade)
    end

    --setgroup
    MBLFunctions["setGroup"] = function(source, group)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?
        return xPlayer.setGroup(group)
    end

    --setrol
    MBLFunctions["setRol"] = function(source, rol)
        -- n/a
        return true
    end

    --addcurrency
    MBLFunctions["addCurrency"] = function(source, currency, amount)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?

        --The currency type (0 = money, 1 = gold, 2 = black money)
        xPlayer.addAccount(currency, amount)
        return true
    end

    MBLFunctions["removeCurrency"] = function(source, currency, amount)
        local xPlayer = TPZ.GetPlayer(source)
         
        if not xPlayer.loaded() then return end -- is player in session?

        --The currency type (0 = money, 1 = gold, 2 = black money)
        xPlayer.removeAccount(currency, amount)
        return true
    end
    
    CASFWLibs = true
end

MBLFunctions["getDiscord"] = function(src)
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(id, 1, 8) == "discord:" then
            return string.sub(id, 9)
        end
    end
    return "Unknown"
end

exports("MBLFunctions", function()
    while not CASFWLibs do Wait(0) end
    return MBLFunctions
end)