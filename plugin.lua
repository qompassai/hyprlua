#!/usr/bin/env lua
-- /qompassai/lua/lua_ls/addons/hyprlua/plugin.lua
-- Qompass AI HyprLua lua_ls Addon - Text Transform Plugin
-- Copyright (C) 2026 Qompass AI, All rights reserved.
-- SPDX-License-Identifier: Apache-2.0
---@class diff
---@field start  integer
---@field finish integer
---@field text   string

---@param uri  string
---@param text string
---@return nil|diff[]
function OnSetText(uri, text)
    if not uri:match('hypr.*%.lua$') then
        return nil
    end
    if text:sub(1, 8) == '--#!hypr' then
        return {
            { start = 1, finish = text:find('\n') or 8, text = '' },
        }
    end

    return nil
end
