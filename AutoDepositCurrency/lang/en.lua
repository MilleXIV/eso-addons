local strings = {
    ADC_NAME = "AutoDepositCurrency",
    ADC_LONG_NAME = "Auto Deposit Currency",
    ADC_DESCRIPTION = "An addon to automatically deposit currencies when you open your bank",
    ADC_DEPOSIT = "Deposited <<1>> <<2>>",
    ADC_DEPOSIT_OPTION = "Deposit <<1>>",

    ADC_GOLD = "Gold",
    ADC_GOLD_KEEP = "Keep Gold",
    ADC_GOLD_KEEP_TT = "Amount of Gold to keep on character",

    ADC_AP = "Alliance Points",
    ADC_AP_KEEP = "Keep Alliance Points",
    ADC_AP_KEEP_TT = "Amount of Alliance Points to keep on character",

    ADC_TV = "Tel Var Stones",
    ADC_TV_KEEP = "Keep Tel Var Stones",
    ADC_TV_KEEP_TT = "Amount of Tel Var Stones to keep on character",

    ADC_VOUCHERS = "Writ Vouchers",
    ADC_VOUCHERS_KEEP = "Keep Vouchers",
    ADC_VOUCHERS_KEEP_TT = "Amount of Writ Vouchers to keep on character",

    ADC_RESET_NAME = "Reset to Defaults",
    ADC_RESET_BUTTON = "Reset to Defaults",
    ADC_RESET_WARNING = "This will reset AutoDepositCurrency settings to their defaults!"
}

for id, val in pairs(strings) do
    ZO_CreateStringId(id, val)
    SafeAddVersion(id, 1)
end