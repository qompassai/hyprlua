#!/usr/bin/env lua5.4
---@version 5.4
-- exec.lua
-- Qompass AI Hyprlua Runtime Exec Module
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
local exec = require('hyprlua.runtime.modules.exec')
exec.once('waybar')
exec.once('hyprpaper')
exec.once_all({ 'dunst', 'nm-applet', 'blueman-applet' })
local hostname = exec.capture('hostname')
