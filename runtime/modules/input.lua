#!/usr/bin/env lua
---@version 5.4
-- /qompassai/hyprlua/runtime/modules/input.lua
-- Qompass AI HyprLua Runtime Input Module
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
local input = require('hyprlua.runtime.modules.input')
input.keyboard({ kb_layout = 'us,ru', repeat_rate = 30 })
input.touchpad({ tap_to_click = true, natural_scroll = true })
input.next_layout()
