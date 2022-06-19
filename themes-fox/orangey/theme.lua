--[[
    FOX Construction

    Search for FOX_INSTRUCTION in this file
    for quick links to common configurations

    Uses font: Fira Sans
    
    CPU click runs:
     btop, ntop, xterm (or kitty, to open them)
    
    Volume Click runs
     pavucontrol, pactl
    
--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local round_rect_8 = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(8))
end

-- THEME
--
local theme         = {}
theme.dir           = awful.util.theme_dir -- set in rc.lua

-- Beautiful variables
--
-- FOX_INSTRUCTION 2 : Main Font and Wallpaper
--
theme.font          = "Fira Sans 10"
theme.wallpaper     = theme.dir .. "/wallpaper/polys.jpg"

theme.awesome_icon  = theme.dir .. "/icons/menu/awesome.png"

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(0) -- window border
theme.border_normal = "#121212"
theme.border_focus  = "#292929"
theme.border_marked = "#292929"

theme.fg_normal     = "#747474"
theme.fg_focus      = "#DDDCFF"
theme.bg_normal     = "#121212"
theme.bg_focus      = "#121212"
theme.fg_urgent     = "#CC9393"
theme.bg_urgent     = "#2A1F1E"


-- WIBAR
--
local bar_bg_color      = "#00000000"
local bar_cell_bg_color = "#0000007F"

--
theme.wibar_opacity = 1      -- between 0 and 1.
theme.wibar_bg = "#00000000" -- Transparent. Wibar isn't the bar you see
                             -- with bar_bg_color. If you set border to
                             -- the wibar, it will "float"
 
--theme.wibar_stretch 	    If the wibar needs to be stretched to fill the screen.
--theme.wibar_border_width 	The wibar border width.
--theme.wibar_border_color 	The wibar border color.
--theme.wibar_ontop 	    If the wibar is to be on top of other windows.
--theme.wibar_cursor 	    The wibar’s mouse cursor.

--theme.wibar_type 	        The window type (desktop, normal, dock, …).
--theme.wibar_bgimage 	    The wibar’s background image.
--theme.wibar_fg 	        The wibar’s foreground (text) color.
--theme.wibar_shape 	    The wibar’s shape.


-- TAGLIST
--
awful.util.tagnames              = { "1", "2", "3", "4", "5" }

local taglist_selected_color     = "#FE5000" --orange
local taglist_unselected_color   = "#777777" -- grey

-- FOX INSTRUCTION 3 : TAGLIST FONT
theme.taglist_font               = "Fira Sans 10"

theme.taglist_shape              = gears.shape.circle       -- The main shape used for the elements.
theme.taglist_shape_border_width = dpi(1)                   -- The shape elements border width.
theme.taglist_shape_border_color = taglist_unselected_color -- The elements shape border color.

-- Default (Empty)
theme.taglist_shape_border_color_empty = taglist_unselected_color
theme.taglist_fg_empty                 = taglist_unselected_color
theme.taglist_bg_empty                 = bar_bg_color

-- Occupied
theme.taglist_shape_border_color       = taglist_selected_color
theme.taglist_fg_occupied              = "#FFFFFF"
theme.taglist_bg_occupied              = bar_bg_color

-- Focused
theme.taglist_shape_border_color_focus = taglist_selected_color
theme.taglist_fg_focus                 = "#FFFFFF"
theme.taglist_bg_focus                 = taglist_selected_color


-- MENU
--
theme.distro_icon                      = theme.awesome_icon
theme.menu_submenu_icon                = theme.dir .. "/icons/menu/submenu.png"
--theme.menu_font 	The menu text font.
theme.menu_height                      = dpi(32)
theme.menu_width                       = dpi(256)
--theme.menu_border_color 	The menu item border color.
--theme.menu_border_width 	The menu item border width.
theme.menu_fg_focus  = taglist_selected_color
theme.menu_bg_focus  = "#000000"
theme.menu_fg_normal = "#FFFFFF"
theme.menu_bg_normal = "#303030"

local myMenu =
{
    --MENU CONTAINER
    widget = wibox.container.background,
    bg     = bar_cell_bg_color,
    shape  = round_rect_8,
    {
        widget  = wibox.container.margin,
        margins = dpi(6),
        awful.widget.button({ image = theme.distro_icon })
    },
    buttons = awful.util.table.join(
        awful.button({}, 1, function() -- left click
            awful.util.mymainmenu:toggle()
        end),
        awful.button({}, 3, function() -- right click
            awful.spawn.with_shell(awful.util.applauncher)
        end)
    )
}


-- LAYOUT
--
local layoutDir = theme.dir .. "/icons/wibar/layout/"

theme.layout_tile       = layoutDir .. "tile.svg"
theme.layout_tileleft   = layoutDir .. "tile_left.svg"
theme.layout_tilebottom = layoutDir .. "tile_bottom.svg"
theme.layout_tiletop    = layoutDir .. "tile_top.svg"
theme.layout_fairv      = layoutDir .. "fair_v.svg"
theme.layout_fairh      = layoutDir .. "fair_h.svg"
theme.layout_spiral     = layoutDir .. "spiral.svg"
theme.layout_dwindle    = layoutDir .. "dwindle.svg"
theme.layout_max        = layoutDir .. "max.svg"
theme.layout_fullscreen = layoutDir .. "fullscreen.svg"
theme.layout_magnifier  = layoutDir .. "magnifier.svg"
theme.layout_floating   = layoutDir .. "floating.svg"


-- TASKLIST
--
--theme.tasklist_fg_normal 	The default foreground (text) color.
theme.tasklist_bg_normal = bar_cell_bg_color --	The default background color.
--theme.tasklist_fg_focus  = bar_cell_bg_color --	The focused client foreground (text) color.
theme.tasklist_bg_focus = bar_cell_bg_color -- The focused client background color.
--theme.tasklist_fg_urgent 	The urgent clients foreground (text) color.
--theme.tasklist_bg_urgent 	The urgent clients background color.
--theme.tasklist_fg_minimize 	The minimized clients foreground (text) color.
--theme.tasklist_bg_minimize 	The minimized clients background color.
--theme.tasklist_bg_image_normal 	The elements default background image.
--theme.tasklist_bg_image_focus 	The focused client background image.
--theme.tasklist_bg_image_urgent 	The urgent clients background image.
--theme.tasklist_bg_image_minimize 	The minimized clients background image.
theme.tasklist_disable_icon = false -- 	Disable the tasklist client icons.
--theme.tasklist_disable_task_name 	Disable the tasklist client titles.
theme.tasklist_plain_task_name = true -- 	Disable the extra tasklist client property notification icons.
--theme.tasklist_font 	The tasklist font.
--theme.tasklist_align = 'center' -- The focused client alignment.
--theme.tasklist_font_focus 	The focused client title alignment.
--theme.tasklist_font_minimized 	The minimized clients font.
--theme.tasklist_font_urgent 	The urgent clients font.
theme.tasklist_spacing = dpi(6) -- The space between the tasklist elements.
--theme.tasklist_shape = round_rect_8 -- 	The default tasklist elements shape.
--theme.tasklist_shape_border_width = dpi(1) -- 	The default tasklist elements border width.
--theme.tasklist_shape_border_color = "#aaaaaa" -- 	The default tasklist elements border color.
--theme.tasklist_shape_focus 	The focused client shape.
--theme.tasklist_shape_border_width_focus = dpi(1) -- The focused client border width.
--theme.tasklist_shape_border_color_focus = "#ffffff" -- The focused client border color.
--theme.tasklist_shape_minimized 	The minimized clients shape.
--theme.tasklist_shape_border_width_minimized 	The minimized clients border width.
--theme.tasklist_shape_border_color_minimized 	The minimized clients border color.
--theme.tasklist_shape_urgent 	The urgent clients shape.
--theme.tasklist_shape_border_width_urgent 	The urgent clients border width.
--theme.tasklist_shape_border_color_urgent 	The urgent clients border color.

theme.tasklist_fox_menu_width  = dpi(512)
theme.tasklist_fox_menu_height = dpi(48)


-- SYSTRAY
--
theme.systray_icon_spacing = dpi(8)
theme.bg_systray           = bar_cell_bg_color

local mySysTray =
{
    widget = wibox.container.background,
    bg     = bar_cell_bg_color,
    shape  = round_rect_8,
    {
        widget  = wibox.container.margin,
        margins = dpi(6),
        wibox.widget.systray()
    }
}

-- KEYBOARD
--
local myKeyboard =
{
    widget = wibox.container.background,
    bg     = bar_cell_bg_color,
    shape  = round_rect_8,
    {
        widget  = wibox.container.margin,
        margins = dpi(6),
        awful.widget.keyboardlayout()
    }
}


-- Client TITLEBAR

theme.titlebar_fox_height = dpi(10)

local titleBarDir = theme.dir .. "/icons/titlebar/"
--
--beautiful.titlebar_fg_normal 	    -- The titlebar foreground (text) color.
--beautiful.titlebar_bg_normal 	    -- The titlebar background color.
--beautiful.titlebar_bgimage_normal -- The titlebar background image image.
--beautiful.titlebar_fg 	        -- The titlebar foreground (text) color.
--beautiful.titlebar_bg 	        -- The titlebar background color.
--beautiful.titlebar_bgimage 	    -- The titlebar background image image.
--beautiful.titlebar_fg_focus 	    -- The focused titlebar foreground (text) color.
theme.titlebar_bg_focus = "#292929" -- The focused titlebar background color.
--beautiful.titlebar_bgimage_focus 	-- The focused titlebar background image image.
--beautiful.titlebar_floating_button_normal
--beautiful.titlebar_minimize_button_normal
--beautiful.titlebar_minimize_button_normal_hover
--beautiful.titlebar_minimize_button_normal_press
--beautiful.titlebar_ontop_button_normal
--beautiful.titlebar_sticky_button_normal
--beautiful.titlebar_floating_button_focus
--beautiful.titlebar_maximized_button_focus
--beautiful.titlebar_minimize_button_focus
--beautiful.titlebar_minimize_button_focus_hover

--CLOSE
--theme.titlebar_close_button_normal_press
theme.titlebar_close_button_normal                    = titleBarDir .. "strip-normal-blue.svg" 
theme.titlebar_close_button_normal_hover 	          = titleBarDir .. "strip-hover-red.svg"
theme.titlebar_close_button_focus                     = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_close_button_focus_hover               = titleBarDir .. "strip-hover-red.svg"

--FLOATING-Active
theme.titlebar_floating_button_normal_active          = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_floating_button_normal_active_hover    = titleBarDir .. "strip-hover-yellow2.svg"
theme.titlebar_floating_button_focus_active           = titleBarDir .. "strip-normal-grey.svg"
theme.titlebar_floating_button_focus_active_hover 	  = titleBarDir .. "strip-hover-yellow2.svg"
--FLOATING-Inactive
theme.titlebar_floating_button_normal_inactive        = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_floating_button_normal_inactive_hover  = titleBarDir .. "strip-hover-purple.svg"
theme.titlebar_floating_button_focus_inactive         = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_floating_button_focus_inactive_hover   = titleBarDir .. "strip-hover-purple.svg"

--MAXIMIZE-Active
--theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_active         = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_maximized_button_normal_active_hover   = titleBarDir .. "strip-hover-yellow.svg"
theme.titlebar_maximized_button_focus_active          = titleBarDir .. "strip-normal-grey.svg"
theme.titlebar_maximized_button_focus_active_hover 	  = titleBarDir .. "strip-hover-yellow.svg"
--MAXIMIZE-Inactive
theme.titlebar_maximized_button_normal_inactive       = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_maximized_button_normal_inactive_hover = titleBarDir .. "strip-hover-green.svg"
theme.titlebar_maximized_button_focus_inactive        = titleBarDir .. "strip-normal-blue.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = titleBarDir .. "strip-hover-green.svg"

--theme.titlebar_ontop_button_focus
--theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
--theme.titlebar_ontop_button_normal_active_hover
--theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
--theme.titlebar_ontop_button_focus_active_hover
--
--theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
--theme.titlebar_ontop_button_normal_inactive_hover
--theme.titlebar_ontop_button_focus_inactive  = theme.dir .. "/icons/titlebar/ontop_button_focus_inactive.png"
--theme.titlebar_ontop_button_focus_inactive_hover

--theme.titlebar_sticky_button_focus
--theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
--theme.titlebar_sticky_button_normal_active_hover
--theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
--theme.titlebar_sticky_button_focus_active_hover
--
--theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
--theme.titlebar_sticky_button_normal_inactive_hover
--theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
--theme.titlebar_sticky_button_focus_inactive_hover


local markup     = lain.util.markup
local separators = lain.util.separators
local white      = theme.fg_focus
local gray       = "#858585"


-- Textclock and Calendar
--
local mytextclock = wibox.widget.background()

local pita_textclock = wibox.widget.textclock(
 markup(gray, " %a") .. markup(white, " %d ") .. markup(gray, "%b ") ..  markup(white, "%H:%M ")
)
pita_textclock.font = theme.font

mytextclock:set_widget(pita_textclock)
mytextclock:set_bg(bar_cell_bg_color)
mytextclock:set_shape(round_rect_8)

theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Fira Sans Light 12",
        fg   = white,
        bg   = theme.bg_normal
}})


-- VOLUME
--
-- FOX INSTRUCTION 4 : USES "PULSE"AUDIO: lain.pulse, pavucontrol, pactl
--                     Change to "ALSA" counterparts if using alsa.
--
theme.vol_low  = theme.dir .. "/icons/wibar/volume/volume-low.svg"
theme.vol_norm = theme.dir .. "/icons/wibar/volume/volume-medium.svg"
theme.vol_high = theme.dir .. "/icons/wibar/volume/volume-high.svg"
theme.vol_mute = theme.dir .. "/icons/wibar/volume/volume-variant-off.svg"

local imgVol = wibox.widget.imagebox(theme.vol_norm)

theme.volume = lain.widget.pulse {

    settings = function()

        local volumen = tonumber(volume_now.left) or 0

        if volume_now.muted ~= "yes" then

            if volumen < 33 then
                imgVol:set_image(theme.vol_low)
            elseif volumen < 66 then
                imgVol:set_image(theme.vol_norm)
            else
                imgVol:set_image(theme.vol_high)
            end

            widget:set_markup(lain.util.markup("#7493d2", volume_now.left))

        else
            imgVol:set_image(theme.vol_mute)
            widget:set_text("X")
        end

    end
}


local myVolume =
{
    widget = wibox.container.background,
    bg     = bar_cell_bg_color,
    shape = round_rect_8,
    {
        widget = wibox.container.margin,
        margins = dpi(10),
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(6),
            imgVol,
            theme.volume
         }
    },

    buttons = awful.util.table.join(
       --os.execute(string.format("pactl set-sink-mute %s toggle", theme.volume.device))
       awful.button({}, 1, function() -- left click
           awful.spawn("pavucontrol")
       end),
       awful.button({}, 2, function() -- middle click
           os.execute("pactl set-sink-volume @DEFAULT_SINK@ 100%%")
           theme.volume.update()
       end),
       awful.button({}, 3, function() -- right click
           os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
           theme.volume.update()
       end),
       awful.button({}, 4, function() -- scroll up
           os.execute("pactl set-sink-volume @DEFAULT_SINK@ +1%")
           theme.volume.update()
       end),
       awful.button({}, 5, function() -- scroll down
           os.execute("pactl set-sink-volume @DEFAULT_SINK@ -1%")
           theme.volume.update()
       end)
    )
}


-- CPU
--
theme.cpu_ok = theme.dir .. "/icons/wibar/cpu.svg"
theme.cpu_33 = theme.dir .. "/icons/wibar/cpu-orange.svg"
theme.cpu_66 = theme.dir .. "/icons/wibar/cpu-red.svg"

local imgCpu = wibox.widget.imagebox(theme.cpu_icon)

theme.cpu = lain.widget.cpu({
    settings = function()

        if cpu_now.usage < 33 then
            widget:set_markup(markup.font(theme.font, markup("#7F7F7F", string.format("%02d",cpu_now.usage))))
            imgCpu:set_image(theme.cpu_ok)
        elseif cpu_now.usage < 66 then
            widget:set_markup(markup.font(theme.font, markup("#FF7F00", string.format("%02d",cpu_now.usage))))
            imgCpu:set_image(theme.cpu_33)
        else
            widget:set_markup(markup.font(theme.font, markup("#FF0000", string.format("%02d",cpu_now.usage))))
            imgCpu:set_image(theme.cpu_66)
        end
    end
})

local myCpu =
{
    widget = wibox.container.background,
    bg     = bar_cell_bg_color,
    shape = round_rect_8,
    {
        widget = wibox.container.margin,

        margins = dpi(11),
        {
           layout = wibox.layout.fixed.horizontal,
           spacing = dpi(6),
           imgCpu,
           theme.cpu
        }
    },
    buttons = awful.util.table.join(
        awful.button({}, 1, function() -- left click
            awful.spawn("xterm btop")
        end),
        awful.button({}, 3, function() -- right click
            awful.spawn("xterm nvtop")
        end)
    )
}


function theme.at_screen_connect(s)
    -- Quake application
    --s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mylayoutbox:buttons(
        my_table.join(
            awful.button({}, 1, function () awful.layout.inc( 1) end),
          --awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
            awful.button({}, 3, function () awful.layout.inc(-1) end)
          --awful.button({}, 4, function () awful.layout.inc( 1) end),
          --awful.button({}, 5, function () awful.layout.inc(-1) end)
        )
    )

    s.mytaglist = awful.widget.taglist {

        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,

        layout = {
            spacing = dpi(8),
            layout  = wibox.layout.fixed.horizontal
        },

        widget_template = {

            layout = wibox.layout.fixed.horizontal,
            widget = wibox.container.margin,
            {
                id =    'background_role',
                widget = wibox.container.background,
                {
                    widget = wibox.container.margin,
                    margins = dpi(8),
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    }
                }
            }
        }
    } -- taglist

    -- Create a tasklist widget

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter= awful.widget.tasklist.filter.currenttags,
        buttons =awful.util.tasklist_buttons,
        style =  { shape = round_rect_8},

        widget_template = {
            id     = "background_role",
            widget = wibox.container.background,
            {
                left  = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin,
                {
                    spacing = dpi(8),
                    layout = wibox.layout.fixed.horizontal,
                    {
                        top = dpi(8), bottom = dpi(8),
                        widget  = wibox.container.margin,
                        {
                            id     = "icon_role",
                            widget = wibox.widget.imagebox
                        }
                    },
                    {
                        id     = "text_role",
                        widget = wibox.widget.textbox
                    }
                }
            }
        }
    }

    -- Create the wibox
	 s.mywibox = awful.wibar({
	    position = "top",
        screen = s,
        height = dpi(42),
    })

    local padding = wibox.widget.textbox('<span font="Fira Sans Regular 8"> </span>')

    -- Add widgets to the wibox
    s.mywibox:setup
    {
        -- Visually-fake bar.
        -- BG transparent color in theme
        -- Opacity for whole bar in theme!!
        widget = wibox.container.margin,
        top    = dpi(0),
        left   = dpi(0),
        right  = dpi(0),
        bottom = dpi(0),
        {
            -- Visually-real bar
            widget = wibox.container.background,
            bg     = bar_bg_color,
            shape  = round_rect_8,
            {
                widget = wibox.container.margin,
                top    = dpi(6),
                left   = dpi(6),
                right  = dpi(6),
                bottom = dpi(0),
                --shape_border_width = dpi(2),
                {
                    layout = wibox.layout.align.horizontal,

                    {
                        -- LEFT WIDGETS
                        layout = wibox.layout.fixed.horizontal,
                        spacing = dpi(6),
                        myMenu,
                        {
                            -- TAGLIST/LAYOUT Container
                            widget = wibox.container.background,
                            bg     = bar_cell_bg_color,
                            shape  = round_rect_8,
                            {
                                layout = wibox.layout.fixed.horizontal,
                                spacing = dpi(6),

                                padding,
                                s.mytaglist, -- TAGLIST

                                {
                                    -- LAYOUTBOX
                                    widget = wibox.container.margin,
                                    s.mylayoutbox,
                                    margins=dpi(8)
                                }

                            }
                        },
                        s.mypromptbox
                    },

                    s.mytasklist, -- MIDDLE WIDGET. TASKS

                    {
                        -- RIGHT WIDGETS
                        layout = wibox.layout.fixed.horizontal,
                        spacing = dpi(6),

                        padding,
                        mySysTray,
                        myKeyboard,
                        myCpu,
                        myVolume,
                        mytextclock
                    }
                }
            }
        }
    } -- wibox

end -- theme.at_screen_connect

return theme
