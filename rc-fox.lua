--[[

    Awesome WM configuration template

    FOX. Based on: https://github.com/lcpz/awesome-copycats


    Mandatory:
    =========
    
     lain           -> Widget framework (Lua code, included)
                       https://github.com/lcpz/lain

    Uses:
    ====
    
     freedesktop    -> App Menu (Lua code, included)
                       https://github.com/lcpz/freedesktop
     
     rofi           -> App Launcher (X app)
                       IMPORTANT! Check theme rofi folder
                       for correct resolution config file

     pulseaudio     -> AUDIO
      + pavucontrol    pulseaudio volume control (X app)
      + pactl          libpulse
	  

    Runs:
    ====
    
     setxkbmap es                          -> Sets SPANISH KEYBOARD on X (app)
     
     dex --environment Awesome --autostart -> Runs/starts SYSTRAY APPS (app)
     
     lxpolkit / polkit                     -> Permission elevator (X app)
                                              IMPORTANT If you already have KDE or GNOME
                                              you might have another one already like:
                                              polkit-kde-authentication-agent-1

     picom -b     -> Compositor (VSync, transparency, fades)
	                 Do not use on Virtualbox unless you know
					 how to get around problems it causes.


    Totally Changeable:
    ==================

     flameshot    -> Screenshot     (X app)
     terminator   -> Terminal       (X app) (Kitty doesn't work well with virtualbox)
     featherpad   -> Editor         (X app)
     thunar       -> File Navigator (X app)
     firefox      -> Web Browser    (X app)
     solaar       -> Logitech app   (X app)


    Unused/untested:
     xbacklight
     
     
    Themes use:
    ==========
    
     Jetbrains Mono Font or Fira Sans
     btop  -> System info     (CLI app) opens with xterm or kitty
     nvtop -> top  for nvidia (CLI app) opens with xterm or kitty
     xterm -> if not using kitty (doesn't work with Terminator)
     
     
    Packages summary:
    ================
     
     pacman -S rofi dex
     pacman -S polkit lxsession
	 pacman -S picom
     pacman -S pulseaudio pavucontrol libpulse
     pacman -S terminator flameshot firefox thunar featherpad
     pacman -S solaar 
     
     Themes:
     pacman -S btop nvtop xterm
     pacman -S ttf-jetbrains-mono
     pacman -S ttf-fira-sans
	 
-----

    Search "FOX_INSTRUCTION" in this file to
    jump to setting/apps you might want to customize.
    
    Search "FOX says" for additional comments
    
    Rest of comments are from lcpz

--]]


-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")

local dpi           = beautiful.xresources.apply_dpi
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility

--
-- FOX_INSTRUCTION 1 : All KEYBINDINGS are defined here (but not loaded yet) !!!
--
local foxKeyBindings= require("fox/keybindings"); 

-- }}}


-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
     
        if in_error then return end

        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        }

        in_error = false
    end)
end

local function foxAlert(msg)
    naughty.notify { text = msg }
end

-- }}}


-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

--
-- FOX_INSTRUCTION 2 : THEME
--
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes-fox/archblue/"
--local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes-fox/orangey/"
--local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes-fox/slimblue/"

-- FOX_INSTRUCTION 3 : Check/delete/add STARTUP Apps
awful.spawn.with_shell("setxkbmap es")
awful.spawn.with_shell("dex --environment Awesome --autostart")
awful.spawn.with_shell("picom -b")
awful.spawn("flameshot")
os.execute("/usr/bin/lxpolkit &")
--

-- FOX_INSTRUCTION 4 : More Apps
terminal      = "terminator" --"kitty" --kitty kaput on virtualbox
applauncher   = "rofi -show drun -config " .. theme_dir .. "rofi/config-1080.rasi" 
editor        = os.getenv("EDITOR") or "featherpad"
webbrowser    = "firefox"
filebrowser   = "thunar"
--local scrlocker   =
--

awful.util.terminal    = terminal
awful.util.applauncher = applauncher
awful.util.theme_dir   = theme_dir

-- Loads THEME file !!!
beautiful.init(theme_dir .. "theme.lua")

-- Loads KEYBINDINGS
root.keys(foxKeyBindings.globalKeys)




local vi_focus      = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev    = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
--


-- FOX_INSTRUCTION 5 : Choose preferred layouts
awful.layout.layouts = {

    awful.layout.suit.tile,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center
}
-- FOX_INSTRUCTION 5.1 : Uncomment if using termfair and/or cascade
--[[
lain.layout.termfair.nmaster           = dpi(3)
lain.layout.termfair.ncol              = dpi(1)
lain.layout.termfair.center.nmaster    = dpi(3)
lain.layout.termfair.center.ncol       = dpi(1)
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = dpi(5)
lain.layout.cascade.tile.ncol          = dpi(2)
]]
--


-- TAGLIST BUTTONS
awful.util.taglist_buttons = mytable.join(

    awful.button({  }, mLft, function(t) t:view_only() end),

    awful.button(kMod, mLft, function(t) if client.focus then client.focus:move_to_tag(t) end end),

    awful.button({  }, mRgt, awful.tag.viewtoggle), awful.button(kMod, mRgt,
     function(t)
        if client.focus then client.focus:toggle_tag(t) end
     end)
--  awful.button({  }, mSUp, function(t) awful.tag.viewnext(t.screen) end),
--  awful.button({  }, mSDn, function(t) awful.tag.viewprev(t.screen) end)
)

-- TASKLIST BUTTONS
awful.util.tasklist_buttons = mytable.join(

     awful.button({  }, mLft,
      function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
      end),

     awful.button({  }, mRgt,
      function()
        awful.menu.client_list({
             theme = {
                  width  = beautiful.tasklist_fox_menu_width,
                  height = beautiful.tasklist_fox_menu_height
            } })
      end)
     --awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
     --awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

-- }}}


-- {{{ Menu

--FOX_INSTRUCTION 6: Menu uses Freedesktop. Edit to your own preferences

local myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual",             string.format("%s -e man awesome", terminal) },
   { "Edit config",        string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
   { "Restart AwesomeWM",  awesome.restart }
}

local myQuitMenu = {
    { "Logout",   function() awesome.quit() end },
    { "Reboot",   function() os.execute("reboot") end },
    { "Poweroff", function() os.execute("poweroff") end },
}

awful.util.mymainmenu = freedesktop.menu.build({
   before={
      { "Awesome", myawesomemenu, beautiful.awesome_icon },
   },
   --sub_menu="Apps",
   after = {
      -- FOX says: Bug? Clicking immediately closes it. Selecting and pressing "return" works fine.
      { "Launcher", function() awful.spawn.with_shell(awful.util.applauncher) end },
      { "--" },
      { "Quit", myQuitMenu }
   }
})

-- FOX says: lcpz had this commented
--
-- Hide the menu when the mouse leaves it
awful.util.mymainmenu.wibox:connect_signal("mouse::leave",
function()
    if not awful.util.mymainmenu.active_child or
       (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
       awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox)
    then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
        function()
            if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
                awful.util.mymainmenu:hide()
            end
        end)
    end
end)

-- }}}


-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)

    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)

    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized or c.fullscreen then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end

end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- }}}


--[[ {{{ Mouse bindings

root.buttons(mytable.join(
    awful.button({  }, mRgt, function () awful.util.mymainmenu:toggle() end)
--    awful.button({ }, 4, awful.tag.viewnext),
--    awful.button({ }, 5, awful.tag.viewprev)
))

 }}} --]]



-- Client MOUSE bindings. When on client BODY, NOT titlebar
clientbuttons = mytable.join(
   awful.button({  }, mLft, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button(kMod, mLft, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button(kMod, mRgt, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)



-- }}}

-- {{{ Rules

-- FOX_INSTRUCTION 7 : Mainly forces certain apps to open floating
--                     Last fox instruction. After this, check THEME file

-- Rules to apply to new clients (through the "manage" signal).
--
awful.rules.rules = {

    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            callback = awful.client.setslave,
            focus = awful.client.focus.filter,
            raise = true,
            keys = foxKeyBindings.clientKeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },

    -- pavucontrol FLOATING RIGHT.
    {
        rule =       { instance  = "pavucontrol" },
        properties = { floating  = true,
                       placement = awful.placement.top_right }
    },

    -- Solaar FLOATING RIGHT and to tag 5
    {
        rule =       { class  = "Solaar" },
        properties = { floating  = true,
                       placement = awful.placement.top_right,
                       screen = 1, tag = "5" }
    },

    -- Floating clients.
    {
        properties = { floating = true },

        rule_any = {

            instance = {
                "DTA",    -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry"
            },

            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"},

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },

            role = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = true }
    }

    -- Example: Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    if not c.tbarM then
        c.tbarM= { 
            widget = awful.titlebar.widget.titlewidget(c),
            align  = "left",
            --font = "Jetbrains Mono Thin 6",
            visible = false
        }
        c.tbarP = { size = beautiful.titlebar_fox_height }
    end


    -- Default
    -- buttons for the titlebar
    local titlebarButtons = mytable.join(
        awful.button({  }, mLft, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({  }, mRgt, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end),
        awful.button({  }, mSDn, function ()
            --c:emit_signal("request::activate", "mouse_click", {raise = true})
            foxAlert("t1")
            c.tbarM.visible = false
            c.tbarP = {size = beautiful.titlebar_fox_height}
            c:emit_signal("request::titlebars")
        end),
        awful.button({  }, mSUp, function ()
            --c:emit_signal("request::activate", "mouse_click", {raise = true})
            foxAlert("t2")
            c.tbarM.visible = true
            c.tbarP = nil
            c:emit_signal("request::titlebars")
        end)
    )



    awful.titlebar(c, c.tbarP) : setup {

        layout = wibox.layout.align.horizontal,

        { -- Left
            layout  = wibox.layout.fixed.horizontal,

            --awful.titlebar.widget.iconwidget(c),
            awful.titlebar.widget.floatingbutton(c)
            --awful.titlebar.widget.ontopbutton (c),
            --awful.titlebar.widget.stickybutton(c),
        },
        { -- Middle
            layout  = wibox.layout.flex.horizontal,
            c.tbarM,
            buttons = titlebarButtons
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,

            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
        }
    }

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}
