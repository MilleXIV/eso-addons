local LCM = LibChatMessage("AutoDepositCurrency", "ADC")

AutoDepositCurrency = {
    name = "AutoDepositCurrency",
    author = "MilleXIV",
    version = "1.0.0",
    SV = "ADCVars",
    SV_VER = 1
}

AutoDepositCurrency.Default = {
    gold = { deposit = true, keep = 10000 },
    alliancePoints = { deposit = true, keep = 0 },
    telvar = { deposit = true, keep = 0 },
    vouchers = { deposit = true, keep = 0 }
}

AutoDepositCurrency.currencies = {
    vouchers = {
        type = CURT_WRIT_VOUCHERS
    },
    telvar = {
        type = CURT_TELVAR_STONES
    },
    alliancePoints = {
        type = CURT_ALLIANCE_POINTS
    },
    gold = {
        type = CURT_MONEY
    }
}

local function DepositCurrency(eventCode, bankBag)
    if bankBag ~= BAG_BANK or not IsBankOpen() then
        return
    end

    local depositStr = GetString(ADC_DEPOSIT)

    for type, data in pairs(AutoDepositCurrency.currencies) do
        local val = GetCurrencyAmount(data.type, CURRENCY_LOCATION_CHARACTER)
        val = val - AutoDepositCurrency.saved[type].keep
        if val > 0 then
            if AutoDepositCurrency.saved[type].deposit then
                TransferCurrency(data.type, val, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
                local isSingular = type == "gold" and true or false
                LCM:Print(zo_strformat(depositStr, ZO_LocalizeDecimalNumber(val), GetCurrencyName(data.type, true, false)))
            end
        end
    end

end

local function Init(eventCode, addonName)
    if addonName ~= AutoDepositCurrency.name then
        return
    end
    EVENT_MANAGER:UnregisterForEvent(addonName, eventCode)

    AutoDepositCurrency.saved = ZO_SavedVars:NewAccountWide(AutoDepositCurrency.SV, AutoDepositCurrency.SV_VER, nil, AutoDepositCurrency.Default, GetWorldName())

    EVENT_MANAGER:RegisterForEvent("ADCBankOpen", EVENT_OPEN_BANK, DepositCurrency)
    AutoDepositCurrency.CreateSettings()
end

EVENT_MANAGER:RegisterForEvent(AutoDepositCurrency.name, EVENT_ADD_ON_LOADED, Init)