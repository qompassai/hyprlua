-- /qompassai/lua/lua_ls/addons/hyprlua/library/hl.lua
-- Qompass AI HyprLua Lua_ls Addon - Core API Definitions
-- Copyright (C) 2026 Qompass AI, All rights reserved
-- Source: Hyprland meta/generateLuaStubs.py (v0.55.0)
-- DO NOT edit class/field definitions by hand - regenerate from source.
-- Human-authored doc comments below are intentional additions.
---@meta

-- ── Aliases ───────────────────────────────────────────────────────────────────

---@alias HL.MonitorSelector   string|integer|HL.Monitor
---@alias HL.WorkspaceSelector string|integer|HL.Workspace
---@alias HL.WindowSelector    string|integer|HL.Window

---A Vec2 as an object, {x,y} table, {number,number} array, or "x y" string
---@alias HL.Vec2Like HL.Vec2|{x:number, y:number}|{number, number}|string

---A CSS-like gap: single integer or per-side table
---@alias HL.CssGap integer|{top?:integer, right?:integer, bottom?:integer, left?:integer}

---A color gradient: angle-based or a plain color string
---@alias HL.Gradient string|{colors:string[], angle?:number}

-- ── Primitive types ───────────────────────────────────────────────────────────

---@class HL.Dispatcher
local __HL_Dispatcher = {}

---2D vector
---@class HL.Vec2
---@field x number
---@field y number
local __HL_Vec2 = {}

---Axis-aligned bounding box
---@class HL.Box
---@field x number
---@field y number
---@field w number
---@field h number
local __HL_Box = {}

-- ── Layout types ──────────────────────────────────────────────────────────────

---A single window slot passed to a custom layout's recalculate callback.
---Call :place(box) or :set_box(box) to position the window.
---@class HL.LayoutTarget
---@field box    HL.Box          current box for this target
---@field index  integer         1-based position in ctx.targets
---@field window HL.Window|nil   the window occupying this slot (nil = empty)
---@field place   fun(self: HL.LayoutTarget, box: HL.Box): nil  place and commit
---@field set_box fun(self: HL.LayoutTarget, box: HL.Box): nil  set without committing
local __HL_LayoutTarget = {}

---Context object passed to HL.LayoutProvider.recalculate.
---Use the helper methods to compute boxes, then assign via target:place(box).
---@class HL.LayoutContext
---@field area    HL.Box            total usable work area
---@field targets HL.LayoutTarget[] windows to lay out (ordered, 1-based)
---@field column   fun(self: HL.LayoutContext, i: integer, n: integer): HL.Box
---@field grid_cell fun(self: HL.LayoutContext, i: integer, cols: integer, rows?: integer): HL.Box
---@field row      fun(self: HL.LayoutContext, i: integer, n: integer): HL.Box
---@field split    fun(self: HL.LayoutContext, box: HL.Box, side: 'left'|'right'|'top'|'bottom'|'up'|'down', ratio: number): HL.Box
local __HL_LayoutContext = {}

---Spec table passed to hl.layout.register(name, provider).
---@class HL.LayoutProvider
---@field recalculate fun(ctx: HL.LayoutContext): nil                              required
---@field layout_msg? fun(ctx: HL.LayoutContext, msg: string): boolean|string|nil  optional IPC message handler
local __HL_LayoutProvider = {}

-- ── Bind / keybind types ──────────────────────────────────────────────────────

---Options table for hl.bind(keys, dispatcher, opts).
---All fields are optional.
---@class HL.BindOptions
---@field click?            boolean
---@field desc?             string    alias for description
---@field description?      string
---@field device?           {inclusive?: boolean, list?: string[]}
---@field dont_inhibit?     boolean
---@field drag?             boolean
---@field ignore_mods?      boolean
---@field locked?           boolean   active even when screen is locked
---@field long_press?       boolean
---@field non_consuming?    boolean
---@field release?          boolean   fire on key release instead of press
---@field repeating?        boolean   fire repeatedly while held
---@field submap_universal? boolean
---@field transparent?      boolean
local __HL_BindOptions = {}

---Handle returned by hl.bind(). Use to inspect or remove the binding.
---@class HL.Keybind
---@field arg              string
---@field auto_consuming   boolean
---@field catchall         boolean
---@field click            boolean
---@field description      any
---@field device_inclusive boolean
---@field devices          nil
---@field display_key      string
---@field dont_inhibit     boolean
---@field drag             boolean
---@field enabled          boolean
---@field handler          string
---@field has_description  boolean
---@field ignore_mods      boolean
---@field key              string
---@field keycode          integer
---@field locked           boolean
---@field long_press       boolean
---@field modmask          integer
---@field mouse            boolean
---@field non_consuming    boolean
---@field release          boolean
---@field repeating        boolean
---@field submap           string
---@field submap_universal boolean
---@field transparent      boolean
---@field is_enabled fun(self: HL.Keybind): boolean
---@field remove     fun(self: HL.Keybind): nil
---@field set_enabled fun(self: HL.Keybind, enabled: boolean): nil
---@field unbind     fun(self: HL.Keybind): nil
local __HL_Keybind = {}

-- ── Event types ───────────────────────────────────────────────────────────────

---All compositor event names for use with hl.on(event, cb).
---@alias HL.EventName
---| "config.reloaded"
---| "hyprland.shutdown"
---| "hyprland.start"
---| "keybinds.submap"
---| "layer.closed"
---| "layer.opened"
---| "monitor.added"
---| "monitor.focused"
---| "monitor.layout_changed"
---| "monitor.removed"
---| "screenshare.state"
---| "window.active"
---| "window.class"
---| "window.close"
---| "window.destroy"
---| "window.fullscreen"
---| "window.kill"
---| "window.move_to_workspace"
---| "window.open"
---| "window.open_early"
---| "window.pin"
---| "window.title"
---| "window.update_rules"
---| "window.urgent"
---| "workspace.active"
---| "workspace.created"
---| "workspace.move_to_monitor"
---| "workspace.removed"

---Handle returned by hl.on(). Use to unsubscribe.
---@class HL.EventSubscription
---@field is_active fun(self: HL.EventSubscription): boolean
---@field remove    fun(self: HL.EventSubscription): nil
local __HL_EventSubscription = {}

-- ── Timer types ───────────────────────────────────────────────────────────────

---Options for hl.timer(callback, opts).
---@class HL.TimerOptions
---@field timeout integer          milliseconds
---@field type    "repeat"|"oneshot"
local __HL_TimerOptions = {}

---Handle returned by hl.timer().
---@class HL.Timer
---@field is_enabled  fun(self: HL.Timer): boolean
---@field set_enabled fun(self: HL.Timer, enabled: boolean): nil
---@field set_timeout fun(self: HL.Timer, ms: integer): nil
local __HL_Timer = {}

-- ── Notification types ────────────────────────────────────────────────────────

---Options for hl.notification.create(opts).
---@class HL.NotificationOptions
---@field color?     string
---@field font_size? number
---@field icon?      integer|string  0=none 1=warning 2=info 3=hint 4=error 5=confused 6=ok
---@field timeout?   number          milliseconds
local __HL_NotificationOptions = {}

---Live notification handle returned by hl.notification.create().
---@class HL.Notification
---@field dismiss                  fun(self: HL.Notification): nil
---@field get_color                fun(self: HL.Notification): string
---@field get_elapsed              fun(self: HL.Notification): number
---@field get_elapsed_since_creation fun(self: HL.Notification): number
---@field get_font_size            fun(self: HL.Notification): number
---@field get_icon                 fun(self: HL.Notification): integer|string
---@field get_text                 fun(self: HL.Notification): string
---@field get_timeout              fun(self: HL.Notification): number
---@field is_alive                 fun(self: HL.Notification): boolean
---@field is_paused                fun(self: HL.Notification): boolean
---@field pause                    fun(self: HL.Notification): nil
---@field resume                   fun(self: HL.Notification): nil
---@field set_color                fun(self: HL.Notification, color: string): nil
---@field set_font_size            fun(self: HL.Notification, size: number): nil
---@field set_icon                 fun(self: HL.Notification, icon: integer|string): nil
---@field set_paused               fun(self: HL.Notification, paused: boolean): nil
---@field set_text                 fun(self: HL.Notification, text: string): nil
---@field set_timeout              fun(self: HL.Notification, ms: number): nil
local __HL_Notification = {}

-- ── Layer types ───────────────────────────────────────────────────────────────

---Filter passed to hl.get_layers().
---@class HL.LayerQueryFilter
---@field monitor?   HL.MonitorSelector
---@field namespace? string
local __HL_LayerQueryFilter = {}

---A wlr-layer-shell surface (e.g. waybar, swaybg, swaylock).
---@class HL.LayerSurface
---@field above_fullscreen boolean|nil
---@field address          string
---@field h                integer
---@field interactivity    integer
---@field layer            integer
---@field mapped           boolean
---@field monitor          HL.Monitor|nil
---@field namespace        string
---@field pid              integer
---@field w                integer
---@field x                integer
---@field y                integer
local __HL_LayerSurface = {}

---Rule handle returned by hl.layer_rule().
---@class HL.LayerRule
---@field is_enabled  fun(self: HL.LayerRule): boolean
---@field set_enabled fun(self: HL.LayerRule, enabled: boolean): nil
local __HL_LayerRule = {}

---Spec for hl.layer_rule(spec).
---@class HL.LayerRuleSpec
---@field above_lock?     integer|boolean
---@field animation?      string
---@field blur?           boolean
---@field blur_popups?    boolean
---@field dim_around?     boolean
---@field enabled?        boolean
---@field ignore_alpha?   number|boolean
---@field match?          table
---@field name?           string
---@field no_anim?        boolean
---@field no_screen_share? boolean
---@field order?          integer|boolean
---@field xray?           boolean
local __HL_LayerRuleSpec = {}

-- ── Window types ──────────────────────────────────────────────────────────────

---Filter passed to hl.get_windows().
---@class HL.WindowQueryFilter
---@field class?     string
---@field floating?  boolean
---@field mapped?    boolean
---@field monitor?   HL.MonitorSelector
---@field tag?       string
---@field title?     string
---@field workspace? HL.WorkspaceSelector
local __HL_WindowQueryFilter = {}

---A window group (tabbed/stacked windows).
---@class HL.Group
---@field current       HL.Window|nil
---@field current_index integer
---@field denied        boolean
---@field locked        boolean
---@field members       HL.Window|table|nil
---@field size          integer
local __HL_Group = {}

---A Wayland/XWayland window managed by Hyprland.
---@class HL.Window
---@field accepts_input    boolean
---@field active           boolean|nil
---@field address          string
---@field at               integer|table
---@field class            string          WM_CLASS / app-id
---@field content_type     string
---@field floating         boolean
---@field focus_history_id integer
---@field fullscreen       integer         0=none 1=maximized 2=fullscreen
---@field fullscreen_client integer
---@field group            HL.Group|nil
---@field hidden           boolean
---@field inhibiting_idle  boolean
---@field initial_class    string
---@field initial_title    string
---@field layout           HL.Window|boolean|integer|number|string|table|nil
---@field mapped           boolean
---@field monitor          HL.Monitor|nil
---@field over_fullscreen  boolean
---@field pid              integer
---@field pinned           boolean
---@field size             integer|table
---@field stable_id        integer
---@field swallowing       HL.Window|nil
---@field tags             string|table
---@field title            string
---@field visible          boolean
---@field workspace        HL.Workspace|nil
---@field xdg_description  string|nil
---@field xdg_tag          string|nil
---@field xwayland         boolean
local __HL_Window = {}

---Rule handle returned by hl.window_rule().
---@class HL.WindowRule
---@field is_enabled  fun(self: HL.WindowRule): boolean
---@field set_enabled fun(self: HL.WindowRule, enabled: boolean): nil
local __HL_WindowRule = {}

---Spec for hl.window_rule(spec).
---@class HL.WindowRuleSpec
---@field enabled? boolean
---@field match?   table
---@field name?    string
local __HL_WindowRuleSpec = {}

-- ── Workspace types ───────────────────────────────────────────────────────────

---A Hyprland workspace.
---@class HL.Workspace
---@field active           boolean
---@field config_name      string
---@field fullscreen_mode  integer
---@field fullscreen_window HL.Window|nil
---@field groups           integer|nil
---@field has_fullscreen   boolean
---@field has_urgent       boolean
---@field id               integer         negative = special workspace
---@field is_empty         boolean
---@field is_persistent    boolean
---@field last_window      HL.Window|nil
---@field monitor          HL.Monitor|nil
---@field name             string
---@field special          boolean
---@field tiled_layout     string
---@field visible          boolean
---@field windows          integer         window count
---@field get_groups  fun(self: HL.Workspace): HL.Group[]
---@field get_windows fun(self: HL.Workspace): HL.Window[]
local __HL_Workspace = {}

---Spec for hl.workspace_rule(spec).
---@class HL.WorkspaceRuleSpec
---@field animation?      string
---@field border_size?    integer|boolean
---@field decorate?       boolean
---@field default?        boolean
---@field default_name?   string
---@field enabled?        boolean
---@field float_gaps?     integer|HL.CssGap
---@field gaps_in?        integer|HL.CssGap
---@field gaps_out?       integer|HL.CssGap
---@field layout?         string
---@field layout_opts?    table
---@field monitor?        string
---@field no_border?      boolean
---@field no_rounding?    boolean
---@field no_shadow?      boolean
---@field on_created_empty? string
---@field persistent?     boolean
---@field workspace       string   required: workspace selector string
local __HL_WorkspaceRuleSpec = {}

-- ── Monitor types ─────────────────────────────────────────────────────────────

---A connected output/display.
---@class HL.Monitor
---@field active_special_workspace HL.Workspace|nil
---@field active_workspace         HL.Workspace|nil
---@field description              string
---@field dpms_status              boolean
---@field focused                  boolean|nil
---@field height                   integer
---@field id                       integer
---@field is_mirror                boolean
---@field mirrors                  HL.Monitor|table
---@field name                     string    e.g. "DP-1", "HDMI-A-1"
---@field position                 integer|table
---@field refresh_rate             number
---@field scale                    number
---@field size                     integer|table
---@field transform                integer   wl_output_transform enum value
---@field vrr_active               boolean
---@field width                    integer
---@field x                        integer
---@field y                        integer
local __HL_Monitor = {}

---Spec for hl.monitor(spec).
---@class HL.MonitorSpec
---@field bitdepth?            integer|boolean
---@field cm?                  string
---@field disabled?            boolean
---@field icc?                 string
---@field max_avg_luminance?   integer|boolean
---@field max_luminance?       integer|boolean
---@field min_luminance?       number|boolean
---@field mirror?              string
---@field mode?                string    e.g. "1920x1080@144"
---@field output               string    required: output name
---@field position?            string    e.g. "0x0"
---@field reserved?            integer|HL.CssGap
---@field reserved_area?       integer|HL.CssGap
---@field scale?               string
---@field sdr_eotf?            string
---@field sdr_max_luminance?   integer|boolean
---@field sdr_min_luminance?   number|boolean
---@field sdrbrightness?       number|boolean
---@field sdrsaturation?       number|boolean
---@field supports_hdr?        integer|boolean
---@field supports_wide_color? integer|boolean
---@field transform?           integer|boolean
---@field vrr?                 integer|boolean
local __HL_MonitorSpec = {}

-- ── Gesture / device / permission types ──────────────────────────────────────

---Spec for hl.gesture(spec).
---@class HL.GestureSpec
---@field action           string
---@field direction        string
---@field fingers          integer
---@field disable_inhibit? boolean
---@field mode?            string
---@field mods?            string
---@field scale?           number
---@field workspace_name?  string
---@field zoom_level?      number
local __HL_GestureSpec = {}

---Spec for hl.device(spec). name is required; all other fields are optional overrides.
---@class HL.DeviceSpec
---@field name                      string    required: device name from `hyprctl devices`
---@field absolute_region_position? boolean
---@field accel_profile?            string
---@field active_area_position?     HL.Vec2Like
---@field active_area_size?         HL.Vec2Like
---@field clickfinger_behavior?     boolean
---@field disable_while_typing?     boolean
---@field drag_3fg?                 integer|boolean
---@field drag_lock?                integer|boolean
---@field enabled?                  boolean
---@field flip_x?                   boolean
---@field flip_y?                   boolean
---@field kb_file?                  string
---@field kb_layout?                string
---@field kb_model?                 string
---@field kb_options?               string
---@field kb_rules?                 string
---@field kb_variant?               string
---@field keybinds?                 boolean
---@field left_handed?              boolean
---@field middle_button_emulation?  boolean
---@field natural_scroll?           boolean
---@field numlock_by_default?       boolean
---@field output?                   string
---@field region_position?          HL.Vec2Like
---@field region_size?              HL.Vec2Like
---@field relative_input?           boolean
---@field release_pressed_on_close? boolean
---@field repeat_delay?             integer|boolean
---@field repeat_rate?              integer|boolean
---@field resolve_binds_by_sym?     boolean
---@field rotation?                 integer|boolean
---@field scroll_button?            integer|boolean
---@field scroll_button_lock?       boolean
---@field scroll_factor?            number|boolean
---@field scroll_method?            string
---@field scroll_points?            string
---@field sensitivity?              number|boolean
---@field share_states?             integer|boolean
---@field tags?                     string
---@field tap_and_drag?             boolean
---@field tap_button_map?           string
---@field tap_to_click?             boolean
---@field transform?                integer|boolean
local __HL_DeviceSpec = {}

---Spec for hl.permission(spec).
---@class HL.PermissionSpec
---@field allow  string
---@field binary string
---@field type   string
local __HL_PermissionSpec = {}

-- ── Sub-namespaces ────────────────────────────────────────────────────────────

---hl.dsp.cursor.*
---@class HL.DspCursorNamespace
---@field move          fun(...): HL.Dispatcher
---@field move_to_corner fun(...): HL.Dispatcher
local __HL_DspCursorNamespace = {}

---hl.dsp.group.*
---@class HL.DspGroupNamespace
---@field active      fun(...): HL.Dispatcher
---@field lock        fun(...): HL.Dispatcher
---@field lock_active fun(...): HL.Dispatcher
---@field move_window fun(...): HL.Dispatcher
---@field next        fun(...): HL.Dispatcher
---@field prev        fun(...): HL.Dispatcher
---@field toggle      fun(...): HL.Dispatcher
local __HL_DspGroupNamespace = {}

---hl.dsp.window.*
---@class HL.DspWindowNamespace
---@field alter_zorder   fun(...): HL.Dispatcher
---@field bring_to_top   fun(...): HL.Dispatcher
---@field center         fun(...): HL.Dispatcher
---@field clear_tags     fun(...): HL.Dispatcher
---@field close          fun(...): HL.Dispatcher
---@field cycle_next     fun(...): HL.Dispatcher
---@field deny_from_group fun(...): HL.Dispatcher
---@field drag           fun(...): HL.Dispatcher
---@field float          fun(...): HL.Dispatcher
---@field fullscreen     fun(...): HL.Dispatcher
---@field fullscreen_state fun(...): HL.Dispatcher
---@field kill           fun(...): HL.Dispatcher
---@field move           fun(...): HL.Dispatcher
---@field pin            fun(...): HL.Dispatcher
---@field pseudo         fun(...): HL.Dispatcher
---@field resize         fun(...): HL.Dispatcher
---@field set_prop       fun(...): HL.Dispatcher
---@field signal         fun(...): HL.Dispatcher
---@field swap           fun(...): HL.Dispatcher
---@field tag            fun(...): HL.Dispatcher
---@field toggle_swallow fun(...): HL.Dispatcher
local __HL_DspWindowNamespace = {}

---hl.dsp.workspace.*
---@class HL.DspWorkspaceNamespace
---@field move           fun(...): HL.Dispatcher
---@field rename         fun(...): HL.Dispatcher
---@field swap_monitors  fun(...): HL.Dispatcher
---@field toggle_special fun(...): HL.Dispatcher
local __HL_DspWorkspaceNamespace = {}

---hl.dsp.*  Top-level dispatcher namespace.
---@class HL.DspNamespace
---@field cursor   HL.DspCursorNamespace
---@field dpms     fun(...): HL.Dispatcher
---@field event    fun(...): HL.Dispatcher
---@field exec_cmd fun(...): HL.Dispatcher
---@field exec_raw fun(...): HL.Dispatcher
---@field exit     fun(...): HL.Dispatcher
---@field focus    fun(...): HL.Dispatcher
---@field force_idle             fun(...): HL.Dispatcher
---@field force_renderer_reload  fun(...): HL.Dispatcher
---@field global   fun(...): HL.Dispatcher
---@field group    HL.DspGroupNamespace
---@field layout   fun(...): HL.Dispatcher
---@field no_op    fun(...): HL.Dispatcher
---@field pass     fun(...): HL.Dispatcher
---@field send_key_state  fun(...): HL.Dispatcher
---@field send_shortcut   fun(...): HL.Dispatcher
---@field submap   fun(...): HL.Dispatcher
---@field window   HL.DspWindowNamespace
---@field workspace HL.DspWorkspaceNamespace
local __HL_DspNamespace = {}

---hl.layout.*
---@class HL.LayoutNamespace
---@field register fun(name: string, provider: HL.LayoutProvider): nil
local __HL_LayoutNamespace = {}

---hl.notification.*
---@class HL.NotificationNamespace
---@field create fun(opts?: HL.NotificationOptions): HL.Notification
---@field get    fun(): HL.Notification[]
local __HL_NotificationNamespace = {}

---hl.plugin.*  Hyprland plugin interface.
---@class HL.PluginNamespace
---@field load fun(...): any
---@field [string] any
local __HL_PluginNamespace = {}

-- ── hl global (HL.API) ────────────────────────────────────────────────────────

---The Hyprland 0.55+ Lua configuration API.
---All functions are accessed via the global `hl` table.
---@class HL.API
---@field dsp          HL.DspNamespace
---@field layout       HL.LayoutNamespace
---@field notification HL.NotificationNamespace
---@field plugin       HL.PluginNamespace
---
--- animation: register an animation curve (see hl.curve)
---@field animation    fun(...): any
---
--- bind: attach a key combo to a dispatcher or Lua callback
---@field bind         fun(keys: string, dispatcher: HL.Dispatcher|function, opts?: HL.BindOptions): HL.Keybind
---
--- config: set one or more config values using a nested table
---@field config       fun(config: table): nil
---
--- curve: register a bezier curve for animations
---@field curve        fun(...): any
---
--- define_submap: create a named submap with optional auto-reset
---@field define_submap fun(name: string, reset_or_fn: string|function, fn?: function): nil
---
--- device: configure a specific input device
---@field device       fun(spec: HL.DeviceSpec): nil
---
--- dispatch: execute a dispatcher action
---@field dispatch     fun(dispatcher: HL.Dispatcher|function): any
---
--- env: set an environment variable for child processes
---@field env          fun(...): any
---
--- exec_cmd: run a shell command with optional window rules
---@field exec_cmd     fun(cmd: string, rules?: table): nil
---
--- gesture: register a touchpad/touchscreen gesture binding
---@field gesture      fun(spec: HL.GestureSpec): nil
---
--- get_active_monitor: focused monitor, or nil
---@field get_active_monitor         fun(): HL.Monitor|nil
---
--- get_active_special_workspace: active special workspace on a monitor
---@field get_active_special_workspace fun(monitor?: HL.MonitorSelector): HL.Workspace|nil
---
--- get_active_window: currently focused window, or nil
---@field get_active_window          fun(): HL.Window|nil
---
--- get_active_workspace: active workspace on the focused (or specified) monitor
---@field get_active_workspace       fun(monitor?: HL.MonitorSelector): HL.Workspace|nil
---
--- get_config: read a config value. Returns (value, err_string?)
---@field get_config   fun(key: HL.ConfigKey|string): any, string?
---
--- get_current_submap: active submap name, or "" if none
---@field get_current_submap         fun(): string
---
--- get_cursor_pos: cursor position in compositor space
---@field get_cursor_pos             fun(): HL.Vec2|nil
---
--- get_last_window: previously focused window
---@field get_last_window            fun(): HL.Window|nil
---
--- get_last_workspace: previously active workspace on a monitor
---@field get_last_workspace         fun(monitor?: HL.MonitorSelector): HL.Workspace|nil
---
--- get_layers: layer-shell surfaces, optionally filtered
---@field get_layers   fun(filters?: HL.LayerQueryFilter): HL.LayerSurface[]
---
--- get_monitor: monitor by selector
---@field get_monitor  fun(selector: HL.MonitorSelector): HL.Monitor|nil
---
--- get_monitor_at: monitor at a point in compositor space
---@field get_monitor_at             fun(x: number|HL.Vec2, y?: number): HL.Monitor|nil
---
--- get_monitor_at_cursor: monitor under the cursor
---@field get_monitor_at_cursor      fun(): HL.Monitor|nil
---
--- get_monitors: all connected monitors
---@field get_monitors               fun(): HL.Monitor[]
---
--- get_urgent_window: first window with urgent hint set
---@field get_urgent_window          fun(): HL.Window|nil
---
--- get_window: window by selector (address/class/title/etc.)
---@field get_window   fun(selector: HL.WindowSelector): HL.Window|nil
---
--- get_windows: all windows, optionally filtered
---@field get_windows  fun(filters?: HL.WindowQueryFilter): HL.Window[]
---
--- get_workspace: workspace by selector
---@field get_workspace fun(selector: HL.WorkspaceSelector): HL.Workspace|nil
---
--- get_workspace_windows: all windows on a specific workspace
---@field get_workspace_windows      fun(workspace: HL.WorkspaceSelector): HL.Window[]
---
--- get_workspaces: all workspaces
---@field get_workspaces             fun(): HL.Workspace[]
---
--- layer_rule: register a layer-shell rule
---@field layer_rule   fun(spec: HL.LayerRuleSpec): HL.LayerRule
---
--- monitor: configure a monitor output
---@field monitor      fun(spec: HL.MonitorSpec): nil
---
--- on: subscribe to a compositor event
---@field on           fun(event: HL.EventName, cb: fun(...)): HL.EventSubscription
---
--- permission: declare a security permission grant
---@field permission   fun(spec: HL.PermissionSpec): nil
---
--- timer: create a repeating or one-shot timer
---@field timer        fun(callback: function, opts: HL.TimerOptions): HL.Timer
---
--- unbind: remove a keybind by keys string
---@field unbind       fun(...): any
---
--- version: Hyprland version string
---@field version      fun(): string
---
--- window_rule: register a window rule
---@field window_rule  fun(spec: HL.WindowRuleSpec): HL.WindowRule
---
--- workspace_rule: register a workspace rule
---@field workspace_rule fun(spec: HL.WorkspaceRuleSpec): nil

---@type HL.API
hl = {}
