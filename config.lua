Config = {
    webhookColor           = 16711680,                -- EMBED COLOR
    name                   = "Name City",             -- NAME CITY
    logo                   = "",                      -- HEAD LOGO
    footerLogo             = "",                      -- FOOTER LOGO
    Avatar                 = "",                      -- AVATAR LOGO

    steamName              = true,
    steamURL               = true,
    discordID              = true,
    license                = true,
    license2               = true,
    IP                     = true,

    AutoDisableDrawingTime = 60000,
    AutoDisableDrawing     = false,
    DrawingTime            = 60 * 1000, --60 seconds
    NameorLabel            = 0.1,
    TextColor              = { r = 255, g = 255, b = 255 }, -- WHITE (Player Data)
    AlertTextColor         = { r = 255, g = 0, b = 0 }, -- RED (Player Left Game)

    combatlog              = true,  -- change to false if u dont want combat logging to be recorded
    deathlog               = "https://discord.com/api/webhooks/yourwebhook", -- change to your webhook link
    joining                = "https://discord.com/api/webhooks/yourwebhook",
    leaving                = "https://discord.com/api/webhooks/yourwebhook",
}