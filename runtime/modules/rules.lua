#!/usr/bin/env lua
---@version 5.4
-- rules.lua
-- Qompass AI - [ ]
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
local rules = require('hyprlua.runtime.modules.rules')
rules.float('pavucontrol')
rules.pin('waybar')
rules.assign_workspace('discord', 3, true)

rules.windows({
    { float = true, match = { class = 'nm-applet' } },
    { size = '800 600', match = { class = 'kitty', title = 'float' } },
})
