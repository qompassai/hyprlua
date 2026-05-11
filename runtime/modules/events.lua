#!/usr/bin/env lua

-- events.lua
-- Qompass AI - [ ]
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
local events = require("hyprlua.runtime.modules.events")
events.on("window.active", function(w)
    print("focused: " .. w.title)
end)

-- One-shot — fires once then stops
events.once("hyprland.start", function()
    print("Hyprland started")
end)

-- Debounced — your monitor hotplug pattern from the community [web:253]
events.debounce("monitor.added", 1000, function()
    apply_monitor_layout()
end)
