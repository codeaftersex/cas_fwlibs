MBLFunctions = {}
local CASFWLibs = false

local usingVorp = GetResourceState("vorp_core") == "started"
print("^5 [Code After S*x FW Libs] | ^0 Vorp: " .. tostring(usingVorp))

if usingVorp then
    VorpCore = exports["vorp_core"]:GetCore()

    local function getVorpUserAndCharacter(source)
        local user = VorpCore.getUser(source)
        if not user then return end
        return user, user.getUsedCharacter
    end

    MBLFunctions.getMoney = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.money or 0
    end

    MBLFunctions.AddItem = function(source, item, amount)
        return exports.vorp_inventory:addItem(source, item, amount)
    end

    MBLFunctions.RemoveItem = function(source, item, amount)
        return exports.vorp_inventory:subItem(source, item, amount)
    end

    MBLFunctions.addWeapon = function(source, weapon, ammo, components, comps)
        if not weapon then
            print("Weapon name is required")
            return false
        end

        ammo = ammo or 0
        components = components or {}
        comps = comps or {}

        exports.vorp_inventory:createWeapon(source, weapon)
        return true
    end

    MBLFunctions.removeWeapon = function(source, weaponId)
        return exports.vorp_inventory:subWeapon(source, weaponId)
    end

    MBLFunctions.canCarryItem = function(source, item, count)
        return exports.vorp_inventory:canCarryItem(source, item, count)
    end

    MBLFunctions.canCarryWeapons = function(source, weapon, count)
        count = count or 1
        return exports.vorp_inventory:canCarryWeapons(source, count, false, weapon)
    end

    MBLFunctions.getItemByName = function(source, item)
        return exports.vorp_inventory:getItemByName(source, item)
    end

    MBLFunctions.getInventory = function(source)
        return exports.vorp_inventory:getUserInventoryItems(source)
    end

    MBLFunctions.getItemCount = function(source, item)
        local p = promise:new()
        exports.vorp_inventory:getItemCount(source, function(result)
            p:resolve(result)
        end, item)
        return Citizen.Await(p)
    end

    MBLFunctions.getItem = function(source, item)
        local p = promise:new()
        exports.vorp_inventory:getItem(source, item, function(result)
            p:resolve(result)
        end)
        return Citizen.Await(p)
    end

    MBLFunctions.notify = function(source, message, duration)
        return TriggerClientEvent("notify:show", source, { text = message, duration = duration })
    end

    MBLFunctions.getPlayer = function(source)
        local user, character = getVorpUserAndCharacter(source)
        if not user then return end
        return character
    end

    MBLFunctions.getIdentifier = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.charIdentifier
    end

    MBLFunctions.getGroup = function(source)
        local user = VorpCore.getUser(source)
        if not user then return end
        return user.getGroup
    end

    MBLFunctions.getJobLabel = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.jobLabel
    end

    MBLFunctions.getJob = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.job
    end

    MBLFunctions.getJobGrade = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.jobGrade
    end

    MBLFunctions.getGold = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.gold or 0
    end

    MBLFunctions.getRol = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.rol
    end

    MBLFunctions.getFirstname = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.firstname
    end

    MBLFunctions.getLastname = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.lastname
    end

    MBLFunctions.getFullname = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.firstname .. " " .. character.lastname
    end

    MBLFunctions.isdead = function(source)
        local user = VorpCore.getUser(source)
        if not user then return end
        return user.isdead
    end

    MBLFunctions.getAge = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.age
    end

    MBLFunctions.getGender = function(source)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.gender
    end

    MBLFunctions.getUserByCid = function(cid)
        local user = VorpCore.getUserByCharId(cid)
        if not user then return end
        return user
    end

    MBLFunctions.setJob = function(source, job, grade)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.setJob(job, false)
    end

    MBLFunctions.setJobGrade = function(source, grade)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.setJobGrade(grade, false)
    end

    MBLFunctions.setGroup = function(source, group)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.setGroup(group, false)
    end

    MBLFunctions.setRol = function(source, rol)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        return character.setRol(rol)
    end

    MBLFunctions.addCurrency = function(source, currency, amount)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        character.addCurrency(currency, amount)
        return true
    end

    MBLFunctions.removeCurrency = function(source, currency, amount)
        local _, character = getVorpUserAndCharacter(source)
        if not character then return end
        character.removeCurrency(currency, amount)
        return true
    end

    CASFWLibs = true
end

local usingRSG = GetResourceState("rsg-core") == "started"

if usingRSG then
    print("[Code After S*x FW Libs] | RSG: " .. tostring(usingRSG))
    local rsgInvState = GetResourceState("rsg-inventory") == "started"
    if not rsgInvState then
        print("rsg-inventory is not started")
        return
    end

    RSGCore = exports["rsg-core"]:GetCoreObject()
    RSGInv = exports["rsg-inventory"]

    local function getRSGPlayer(source)
        return RSGCore.Functions.GetPlayer(source)
    end

    MBLFunctions.getMoney = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.money.cash or 0
    end

    MBLFunctions.AddItem = function(source, item, amount)
        return RSGInv:AddItem(source, item, amount)
    end

    MBLFunctions.RemoveItem = function(source, item, amount)
        return RSGInv:RemoveItem(source, item, amount)
    end

    MBLFunctions.addWeapon = function(source, weapon, ammo, components, comps)
        return RSGInv:AddItem(source, weapon, 1)
    end

    MBLFunctions.removeWeapon = function(source, weapon)
        return RSGInv:RemoveItem(source, weapon, 1)
    end

    MBLFunctions.canCarryItem = function(source, item, count)
        return RSGInv:CanAddItem(source, item, count)
    end

    MBLFunctions.canCarryWeapons = function(source, weapon)
        return RSGInv:CanAddItem(source, weapon, 1)
    end

    MBLFunctions.getItemByName = function(source, item)
        return RSGInv:GetItemByName(source, item)
    end

    MBLFunctions.getInventory = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.items
    end

    MBLFunctions.getItemCount = function(source, item)
        return RSGInv:GetItemCount(source, item)
    end

    MBLFunctions.getItem = function(source, item)
        return RSGInv:GetItemByName(source, item)
    end

    MBLFunctions.notify = function(source, message, duration)
        return TriggerClientEvent("notify:show", source, { text = message, duration = duration })
    end

    MBLFunctions.getPlayer = function(source)
        return getRSGPlayer(source)
    end

    MBLFunctions.getIdentifier = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.citizenid
    end

    MBLFunctions.getGroup = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.group
    end

    MBLFunctions.getJobLabel = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.job.label
    end

    MBLFunctions.getJob = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.job.name
    end

    MBLFunctions.getJobGrade = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.job.grade
    end

    MBLFunctions.getGold = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.money.bank
    end

    MBLFunctions.getRol = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.rol
    end

    MBLFunctions.getFirstname = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.charinfo.firstname
    end

    MBLFunctions.getLastname = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.charinfo.lastname
    end

    MBLFunctions.getFullname = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    end

    MBLFunctions.isdead = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.metadata["isdead"]
    end

    MBLFunctions.getAge = function(source)
        local player = getRSGPlayer(source)
        if not player then return end

        local birthdate = player.PlayerData.charinfo.birthdate
        if not birthdate or birthdate == "" then return end

        local year, month, day = birthdate:match("(%d+)-(%d+)-(%d+)")
        year = tonumber(year)
        month = tonumber(month)
        day = tonumber(day)
        if not year or not month or not day then return end

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

    MBLFunctions.getGender = function(source)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.PlayerData.charinfo.gender
    end

    MBLFunctions.getUserByCid = function(cid)
        return RSGCore.Functions.GetPlayerByCitizenId(cid)
    end

    MBLFunctions.setJob = function(source, job, grade)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.Functions.SetJob(job, grade)
    end

    MBLFunctions.setJobGrade = function(source, grade)
        local player = getRSGPlayer(source)
        if not player then return end
        local currentJob = player.PlayerData.job.name
        return player.Functions.SetJob(currentJob, grade)
    end

    MBLFunctions.setGroup = function(source, group)
        local player = getRSGPlayer(source)
        if not player then return end
        local permission = group
        return RSGCore.Functions.AddPermission(player.PlayerData.source, permission)
    end

    MBLFunctions.setRol = function(source, rol)
        local player = getRSGPlayer(source)
        if not player then return end
        return player.Functions.SetRol(rol)
    end

    MBLFunctions.addCurrency = function(source, currency, amount)
        local player = getRSGPlayer(source)
        if not player then return end
        local account = currency == 0 and "cash" or currency == 1 and "bank" or "black_money"
        return player.Functions.AddMoney(account, amount)
    end

    MBLFunctions.removeCurrency = function(source, currency, amount)
        local player = getRSGPlayer(source)
        if not player then return end
        local account = currency == 0 and "cash" or currency == 1 and "bank" or "black_money"
        return player.Functions.RemoveMoney(account, amount)
    end

    CASFWLibs = true
end

local usingTPZCore = GetResourceState("tpz_core") == "started"
print("^5 [Code After S*x FW Libs] | ^0 TPZ-CORE: " .. tostring(usingTPZCore))

if usingTPZCore then
    TPZ = exports.tpz_core:getCoreAPI()

    local function getTPZPlayer(source)
        local xPlayer = TPZ.GetPlayer(source)
        if not xPlayer or not xPlayer.loaded() then return end
        return xPlayer
    end

    MBLFunctions.getMoney = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getAccount(0)
    end

    MBLFunctions.AddItem = function(source, item, amount)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.addItem(item, amount)
    end

    MBLFunctions.RemoveItem = function(source, item, amount)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.removeItem(item, amount)
    end

    MBLFunctions.addWeapon = function(source, weapon, ammo, components, comps)
        if not weapon then
            print("Weapon name is required")
            return false
        end

        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end

        local metadata
        if ammo or components then
            metadata = {}
            if ammo then
                metadata.ammo = ammo
            end
            if components then
                metadata.components = components
            end
        end

        xPlayer.addWeapon(weapon, metadata)
        return true
    end

    MBLFunctions.removeWeapon = function(source, weaponId)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        xPlayer.removeWeaponById(weaponId)
    end

    MBLFunctions.canCarryItem = function(source, item, count)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.canCarryItem(item, count)
    end

    MBLFunctions.canCarryWeapons = function(source, weapon, count)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.canCarryWeapon(weapon)
    end

    MBLFunctions.getItemByName = function(source, item)
        local api = exports.tpz_inventory:getInventoryAPI()
        return api.getItemData(item)
    end

    MBLFunctions.getInventory = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getInventoryContents()
    end

    MBLFunctions.getItemCount = function(source, item)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getItemQuantity(item)
    end

    MBLFunctions.getItem = function(source, item)
        local api = exports.tpz_inventory:getInventoryAPI()
        return api.getItemData(item)
    end

    MBLFunctions.notify = function(source, message, duration)
        return TriggerClientEvent("notify:show", source, { text = message, duration = duration })
    end

    MBLFunctions.getPlayer = function(source)
        return getTPZPlayer(source)
    end

    MBLFunctions.getIdentifier = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getIdentifier()
    end

    MBLFunctions.getGroup = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getGroup()
    end

    MBLFunctions.getJobLabel = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getJob()
    end

    MBLFunctions.getJob = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getJob()
    end

    MBLFunctions.getJobGrade = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getJobGrade()
    end

    MBLFunctions.getGold = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return 0 end
        return xPlayer.getAccount(1)
    end

    MBLFunctions.getRol = function(source)
        return 0
    end

    MBLFunctions.getFirstname = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getFirstName()
    end

    MBLFunctions.getLastname = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getLastName()
    end

    MBLFunctions.getFullname = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getFirstName() .. " " .. xPlayer.getLastName()
    end

    MBLFunctions.isdead = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.isDead()
    end

    MBLFunctions.getAge = function(source)
        return 0
    end

    MBLFunctions.getGender = function(source)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.getGender()
    end

    MBLFunctions.getUserByCid = function(cid)
        return nil
    end

    MBLFunctions.setJob = function(source, job, grade)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        xPlayer.setJob(job)
        if grade then
            xPlayer.setJobGrade(grade)
        end
        return true
    end

    MBLFunctions.setJobGrade = function(source, grade)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.setJobGrade(grade)
    end

    MBLFunctions.setGroup = function(source, group)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        return xPlayer.setGroup(group)
    end

    MBLFunctions.setRol = function(source, rol)
        return true
    end

    MBLFunctions.addCurrency = function(source, currency, amount)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        xPlayer.addAccount(currency, amount)
        return true
    end

    MBLFunctions.removeCurrency = function(source, currency, amount)
        local xPlayer = getTPZPlayer(source)
        if not xPlayer then return end
        xPlayer.removeAccount(currency, amount)
        return true
    end

    CASFWLibs = true
end

MBLFunctions.getDiscord = function(src)
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(id, 1, 8) == "discord:" then
            return string.sub(id, 9)
        end
    end
    return "Unknown"
end

exports("MBLFunctions", function()
    while not CASFWLibs do
        Wait(0)
    end
    return MBLFunctions
end)
