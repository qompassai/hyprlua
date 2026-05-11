#!/usr/bin/env lua5.4
---@version 5.4
-- monitors.lua
-- Qompass AI - [ ]
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- ----------------------------------------
---@module monitors
local M = {}
local _queue = {}
local _disabled = {}
--- @param name                                  string: Monitor identifier (e.g. "desc:LG Electronics 0x1234")
--- @param resolution                            string: Monitor resolution and refresh (e.g. "1920x1080@60.00Hz")
--- @param position                              string: Screen position (e.g. "0x0")
--- @param scale                                 string: Monitor scaling factor (e.g. "1.0")
--- @param workspaces                            table: Optional list of workspaces assigned to this monitor
function M.add(name, resolution, position, scale, workspaces)
        assert(type(name) == 'string', 'Monitor name must be a string')
        assert(type(resolution) == 'string', 'Resolution must be a string')
        assert(type(position) == 'string', 'Position must be a string')
        assert(type(scale) == 'number', 'Scale must be a number')
        assert(workspaces == nil or type(workspaces) == 'table', 'Workspaces must be a table or nil')
        table.insert(_queue, {
                name = name,
                resolution = resolution,
                position = position,
                scale = scale,
                workspaces = workspaces or {},
        })
        if __hypr_add_monitor then
                __hypr_add_monitor(name, resolution, position, scale, workspaces)
        else
                error('__hypr_add_monitor is not defined in Lua runtime')
        end
end
--- Marks a monitor for disabling.
--- @param name                                            string: The monitor name or description to disable
function M.disable(name)
        assert(type(name) == 'string', 'Monitor name must be a string')
        table.insert(_disabled, name)
        if __hypr_disable_monitor then
                __hypr_disable_monitor(name)
        else
                error('__hypr_disable_monitor is not defined in Lua runtime')
        end
end
hypr.monitors = M
return M
