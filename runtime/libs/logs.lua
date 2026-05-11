#!/usr/bin/env lua.4
---@version 5.4
-- logs.lua
-- Qompass AI - [ ]
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
----@module logs
local logs = {}
local colors = {
	reset = "\27[0m",
	red = "\27[31m",
	green = "\27[32m",
	yellow = "\27[33m",
	blue = "\27[34m",
	magenta = "\27[35m",
	cyan = "\27[36m",
	white = "\27[37m",
}
--- @param color string:                                   ANSI escape sequence
--- @param message string:                                 Text to print
local function print_colored(color, message)
	print(color .. message .. colors.reset)
end

--- @param message                                         string: Error text
function logs.error(message)
	print_colored(colors.red, message)
end

--- @param message string: Message text
function logs.print(message)
	print_colored(colors.white, message)
end

return logs
