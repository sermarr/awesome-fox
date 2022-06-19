local gears         = require("gears")
local awful         = require("awful")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility
local lain          = require("lain")

local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")

modkey  = "Mod4" -- Windows key
altkey  = "Mod1" -- Alt Key

--Modifier key Aliases
kCtr = {"Control"}
kMod = { modkey }
kAlt = { altkey }
kC_A = {"Control", altkey}
kC_M = {"Control", modkey}
kM_S = { modkey,  "Shift"}
kM_A = { modkey,   altkey}
kA_S = { altkey,  "Shift"}
kMAS = { modkey,   altkey, "Shift"}

--Mouse Aliases
mLft = 1 -- Left
mMid = 2 -- Middle
mRgt = 3 -- Right
mSUp = 4 -- Scroll Up   (wheel down)
mSDn = 5 -- Scroll Down (wheel up)

local function foxKey(m, k, d, g, f)
    return awful.key (m, k, f, { group = g, description = d })
end

local function foxMakeKeys(gr,T)

    local count = 0
    for _ in pairs(T) do count = count + 1 end

    local keys = {}

    for i = 1, count do
        keys = mytable.join(keys,
            foxKey(T[i][1],T[i][2],T[i][3],gr,T[i][4]))
    end

    return keys
end


-- FOX_INSTRUCTION 7 : KEYBINDINGS !!!
-- Important: Sound keys use pactl not amixer
local globalkeys = mytable.join(

foxMakeKeys("hotkeys", {
{
    kCtr, "space", "destroy all notifications",
    function()
        naughty.destroy_all_notifications()
    end
},{
    kC_A, "l", "lock screen",
    function()
        os.execute(scrlocker)
    end
},{
    {  }, "XF86MonBrightnessUp", "Brightness +10%",   
    function()
        os.execute("xbacklight -inc 10")
    end
},{
    {  }, "XF86MonBrightnessDown", "Brightness -10%", 
    function()
        os.execute("xbacklight -dec 10")
    end
},{
    {  }, "XF86AudioRaiseVolume", "volume up",  
    function()
        os.execute("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        beautiful.volume.update()
    end
},{
    {  }, "XF86AudioLowerVolume", "volume down", 
    function()
        os.execute("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        beautiful.volume.update()
    end
 },{
    {  }, "XF86AudioMute", "toggle mute",  
    function()
        os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        beautiful.volume.update()
    end
},{
    kMod, "c", "copy terminal to gtk",  
    function()
         awful.spawn.with_shell("xsel | xsel -i -b")
    end
},{
    
    kMod, "v", "copy gtk to terminal",  
    function()
        awful.spawn.with_shell("xsel -b | xsel")
    end
}}),

foxMakeKeys("awesome",{
{
    kMod, "s",     "show help",
    hotkeys_popup.show_help
},{
    kMod, "w",     "show main menu",
    function () awful.util.mymainmenu:show() end
},{
    kMod, "space", "toggle wibox",
    function ()
       for s in screen do
           s.mywibox.visible = not s.mywibox.visible
           if s.mybottomwibox then
               s.mybottomwibox.visible = not s.mybottomwibox.visible
           end
       end
    end
},{
    kC_M, "r", "reload awesome",
    awesome.restart
},{
    kM_S, "q",  "quit awesome",
    awesome.quit
},{
    kMod, "x", "lua execute prompt",
    function ()
        awful.prompt.run {
            prompt       = "Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end
}}),

foxMakeKeys("tag", {
{
    kMod, "Left",  "view previous",
     awful.tag.viewprev
},{
    kMod, "Right", "view next",
    awful.tag.viewnext
},{
    kMod, "Escape","go back",
    awful.tag.history.restore
},{
    kAlt, "Left",  "view previous nonempty",
    function() lain.util.tag_view_nonempty(-1) end
},{
    kAlt, "Right", "view previous nonempty",
    function() lain.util.tag_view_nonempty(1) end
},{
    kC_A, "+",     "increment useless gaps",
    function() lain.util.useless_gaps_resize(1) end
},{
    kC_A, "-",     "decrement useless gaps",
    function() lain.util.useless_gaps_resize(-1) end
},{
    kM_S, "n",     "add new tag",
    function() lain.util.add_tag()    end
},{
    kM_S, "r",     "rename tag",
    function() lain.util.rename_tag() end
},{
    kM_S, "Left",  "move tag to the left",
    function() lain.util.move_tag(-1) end
},{
    kM_S, "Right", "move tag to the right",
    function() lain.util.move_tag(1)  end
},{
    kM_S, "d",     "delete tag",
    function() lain.util.delete_tag() end
}}),

foxMakeKeys("client", {
{
    kAlt, "j", "focus next by index",
    function() awful.client.focus.byidx(1) end
},{
    kAlt, "k", "focus previous by index",
    function() awful.client.focus.byidx(-1) end
},{
    kMod, "j", "focus down",
    function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
    end
},{
    kMod, "k", "focus up",
    function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
    end
},{
    kMod, "h", "focus left",
    function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
    end
},{
    kMod, "l", "focus right",
    function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
    end
},{
    -- Layout manipulation
    kM_S, "j",  "swap with next client by index",
    function() awful.client.swap.byidx(  1) end
},{
    kM_S, "k",  "swap with previous client by index",
        function() awful.client.swap.byidx( -1) end
},{
    kMod, "u",  "jump to urgent client",
        awful.client.urgent.jumpto
},{
    kMod, "Tab","cycle with previous/go back",
    function ()
        if cycle_prev then
            awful.client.focus.history.previous()
        else
            awful.client.focus.byidx(-1)
        end
        if client.focus then
            client.focus:raise()
        end
    end
},{
    kC_M, "n", "restore minimized",
    function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end
}}),

foxMakeKeys("screen", {
{
    kC_M, "j",  "focus the next screen",
    function() awful.screen.focus_relative( 1) end
},{
    kC_M, "k",  "focus the previous screen",
    function() awful.screen.focus_relative(-1) end
}}),

foxMakeKeys("launcher", {
{
    kMod, "Return", "Open a terminal",
    function() awful.spawn(terminal) end
},{
    {  },      "Print", "Screenshot",
    function() awful.spawn("flameshot gui") end
},{
    kMod, "r", "App launcher/(R)unner/(R)ofi",
    function() awful.spawn.with_shell(applauncher) end
},{
    kMod, "b", "Web browser",
    function() awful.spawn.with_shell(webbrowser) end
},{
    kMod, "e", "File navigator",
    function() awful.spawn.with_shell(filebrowser) end
}
-- Dropdown application (Fox says: Can't make it work)
-- kMod, "z", "dropdown application",
-- function() awful.screen.focused().quake:toggle() end
}),

foxMakeKeys("layout", {
{
    kM_A, "l", "increase master width factor",
    function() awful.tag.incmwfact( 0.05) end
},{
    kM_A, "h", "decrease master width factor",
    function() awful.tag.incmwfact(-0.05) end
},{
    kM_S, "h", "increase the number of master clients",
    function() awful.tag.incnmaster( 1, nil, true) end
},{
    kM_S, "l", "decrease the number of master clients",
    function() awful.tag.incnmaster(-1, nil, true) end
},{
    kC_M, "h", "increase the number of columns",
    function() awful.tag.incncol( 1, nil, true) end
},{
    kC_M, "l", "decrease the number of columns",
    function() awful.tag.incncol(-1, nil, true) end
}}),

foxMakeKeys("widgets", {
{
    kAlt, "c", "show calendar",
    function()
         if beautiful.cal then beautiful.cal.show(7) end
    end
}})

) -- end globalkeys
 


-- FOX_INSTRUCTION 8 : Client (window) keybindings
--
local clientkeys =
foxMakeKeys("client", {
--{
--    kA_S, "m", "magnify client",  
--    lain.util.magnify_client
--},
{
    kMod, "f", "toggle fullscreen",
    function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end
},{
    kM_S, "c", "close",
    function(c) c:kill() end
},{
    kC_M, "space", "toggle floating",
    awful.client.floating.toggle
},{
    kC_M, "Return", "move to master",
    function(c) c:swap(awful.client.getmaster()) end
},{
    kMod, "o", "move to screen",
    function(c) c:move_to_screen() end
},{
    kMod, "t", "Show small Titlebars",
    function(c)
        c.tbarM.visible = true
        c.tbarP = nil
        c:emit_signal("request::titlebars")
    end
},{
    kM_S, "t", "Show large Titlebar",
    function(c)
        c.tbarM.visible = false
        c.tbarP = {size = beautiful.titlebar_fox_height}
        c:emit_signal("request::titlebars")
    end
},{
    kC_M, "t", "Toggle Titlebar",
    function(c) awful.titlebar.toggle(c) end
},{
    kMAS, "t", "toggle keep on top",
    function(c) c.ontop = not c.ontop end
},{
    kMod, "n", "minimize",
    function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end 
},{
    kMod, "m", "(un)maximize",
    function(c)
        c.maximized = not c.maximized
        c:raise()
    end
},{
    kC_M, "m", "(un)maximize vertically",
    function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end
},{
    kM_S, "m", "(un)maximize horizontally",
    function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end
}})

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do

    globalkeys = mytable.join(globalkeys,

        foxMakeKeys("tag",{
        {
            kMod, "#" .. i + 9, "view tag #"..i, 
            function ()
                local screen = awful.screen.focused()
                local tag    = screen.tags[i]
                if tag then tag:view_only() end
            end
        },{
            kC_M, "#" .. i + 9, "toggle tag #" .. i, 
            function ()
                local screen = awful.screen.focused()
                local tag    = screen.tags[i]
                if tag then awful.tag.viewtoggle(tag) end
            end
        },{
            kM_S, "#" .. i + 9, "move focused client to tag #"..i,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then client.focus:move_to_tag(tag) end
                end
            end
        },{
            { modkey, "Control", "Shift" }, "#" .. i + 9, "toggle focused client on tag #" .. i,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then client.focus:toggle_tag(tag) end
                end
            end
        }})
    )
end -- for

return {globalKeys = globalkeys, clientKeys = clientkeys}
