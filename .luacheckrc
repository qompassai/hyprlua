-- qompassai/hyprlua/.luacheckrc
-- Qompass AI Hyprlua Luacheck Config
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- --------------------------------------------------
return {
    std = 'lua54',
    cache = true,
    codes = true,
    self = false,
    read_globals = {
        'hyprland',
        'hl',
    },
    globals = {
        'arg',
        'require',
        'package',
    },
    ignore = {
        '211',
        '212',
        '411',
        '431',
        '542',
    },
    max_line_length = 150,
    unused_args = false,
    files = {
        ['addon/**/*.lua'] = {
            ignore = {
                '111',
                '112',
                '113',
                '121',
                '131',
                '211',
                '212',
                '311',
                '411',
                '421',
                '431',
                '542',
            },
        },
        ['spec/**/*.lua'] = {
            std = 'lua54+busted',
            globals = {
                'after_each',
                'assert',
                'before_each',
                'describe',
                'it',
                'mock',
                'spy',
            },
        },
        ['.luacheckrc'] = {
            ignore = {
                '111',
                '112',
                '131',
            },
        },
    },
}
