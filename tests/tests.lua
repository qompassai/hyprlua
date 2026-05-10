#!/usr/bin/env lua5.4

-- tests.lua
-- Qompass AI - [ ]
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
local script_dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
local project_root = script_dir .. "../"
package.path = project_root .. "?.lua;"
	.. project_root .. "?/init.lua;"
	.. script_dir .. "?.lua;"
	.. script_dir .. "?/init.lua;"
	.. package.path
local lu = require("lib.luaunit")
require("unit.test_utils")
require("unit.test_logs")
require("unit.test_monitors")
require("unit.test_binds")

os.exit(lu.LuaUnit.run())
