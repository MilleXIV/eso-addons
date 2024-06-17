local ADC = AutoDepositCurrency
local LCM = LibChatMessage("AutoDepositCurrency", "ADC")

function ADC.CreateSettings()
    local LAM = LibAddonMenu2

    local panelName = "ADCPanel"
    local panelData = {
        type = "panel",
        name = GetString(ADC_NAME),
        displayName = GetString(ADC_LONG_NAME),
        author = ADC.author,
        version = ADC.version,
        registerForRefresh = true
    }

    local panel = LAM:RegisterAddonPanel(panelName, panelData)

    local function GetCheckbox(text, key)
        return {
            type = "checkbox",
            name = zo_strformat(GetString(ADC_DEPOSIT_OPTION), text),
            width = "half",
            getFunc = function() return ADC.saved[key].deposit end,
            setFunc = function(val) ADC.saved[key].deposit = val end,
            default = ADC.saved[key].deposit
        }
    end

    local function GetEditbox(text, tt, key)
        return {
            type = "editbox",
            name = text,
            tooltip = tt,
            width = "half",
            isMultiline = false,
            textType = TEXT_TYPE_NUMERIC_UNSIGNED_INT,
            getFunc = function() return ADC.saved[key].keep end,
            setFunc = function(val) ADC.saved[key].keep = tonumber(val) end,
            default = ADC.saved[key].keep,
            disabled = function() return not ADC.saved[key].deposit end
        }
    end

    local optionsData = {
        {
            type = "description",
            title = nil,
            text = GetString(ADC_DESCRIPTION)
        },
        {
            type = "divider"
        },
        GetCheckbox(GetString(ADC_GOLD), "gold"),
        GetEditbox(GetString(ADC_GOLD_KEEP), GetString(ADC_GOLD_KEEP_TT), "gold"),

        GetCheckbox(GetString(ADC_AP), "alliancePoints"),
        GetEditbox(GetString(ADC_AP_KEEP), GetString(ADC_AP_KEEP_TT), "alliancePoints"),

        GetCheckbox(GetString(ADC_TV), "telvar"),
        GetEditbox(GetString(ADC_TV_KEEP), GetString(ADC_TV_KEEP_TT), "telvar"),

        GetCheckbox(GetString(ADC_VOUCHERS), "vouchers"),
        GetEditbox(GetString(ADC_VOUCHERS_KEEP), GetString(ADC_VOUCHERS_KEEP_TT), "vouchers"),

        {
            type = "divider"
        },

        {
            type = "header",
            name = GetString(ADC_RESET_NAME)
        },
        {
            type = "button",
            name = GetString(ADC_RESET_BUTTON),
            isDangerous = true,
            warning = GetString(ADC_RESET_WARNING),
            func = function() ADC.saved:ResetToDefaults() end
        }
    }
    LAM:RegisterOptionControls(panelName, optionsData)
end