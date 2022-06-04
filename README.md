# Fox. An AwesomeWM configuration template

Based on: https://github.com/lcpz/awesome-copycats

It can coexist with lcpz's repo, but the freedesktop and lain directories on this "fox" repo are stripped down.

## Initial instructions

1. Clone or copy files and folders into the following directory (create it if it doesn't exist):

```bash
~/.config/awesome
```

2. **Copy** (don't move) `fox-rc.lua` to `rc.lua`

	Why? `rc.lua` is the file that AwesomeWM reads by default on startup, this way you'll have a copy of it in case it is overwritten, and it won't be overwritten whe cloned in case of pre existing.

3. Inside the `rc.lua` file there are quite a few instructions of mine for what to initially tweak. **READ THEM**. They are the **real** instructions (and not this readme) to tailor everything to your liking. You probably won't get everything working out of the box, you'll have to install things or change them for the ones you want.

	For example, kitty as a Terminal emulator, packages to install, how to select one of the two included themes, etc.

4. I couldn't test multi-monitor because it didn't work for me in Virtualbox.

5. PICOM. This is important. It is the "compositor", it's in charge of transparency and most importantly, of VSYNC. If you don't use, videos and scrolling will get that horrible tearing effect. BUT it doesn't work well onn virtualbox. So, unless you know the workaround, don't use picom on virtualbox, but do install it on a real PC.

## About AwesomeWM. A mini mini tutorial.

Awesome is a window manager... it is **not** a Desktop environment. You can still use all your kde-plasma or gonme crap if you have it installed.

Also, you would still be using icon, cursor, window themes, GTK and QT settings you already have.

### Key combinations you should most definitely know:
(At least to get started, you can change them yourself later)

```
- win + enter: Open Terminal [Terminator]
- win + space: Hide the bar
- win + r:     (R)un. In this case it opens Rofi.
- win + e:     File (E)xplorer [Thunar]
- win + b:     Web (B)rowser [Firefox]
```

You can always swap for your favorite apps editing the rc.lua file.

There are **lots** of key combinations...

**win + s**: launches a popup with a full list of them, but I think it's better to review the rc.lua file.

### Window buttons

My initial goal was to just use something like i3, but I missed more mouse support.

I wanted to close windows or "float" them without having to remember key combinations.

Still, everything can be done with the keyboard. Awesome is awesome, it has everything.

I liked the no-windowbar approach i3 had, to get the maximum sceen space possible, so I made it really thin, and also added some semi-hidden little buttons. They are a bit invisible but they "light up" when you hover over them with mouse cursor.
```
- CLOSE:        top right,
- (Un)MAXIMIZE: just next to it.
- (Un)FLOAT:    on the left side.
```
If they are in "maximized" or "floating" mode the buttons stay "on" with a slight gray color.

**MINIMIZING**: Tiling window managers don't do "minimize", but Awesome being awesome you can still acheive this by clicking on the apps on the TASK bar (called WIBAR in AwesomeWM) and via keyboard of course.

**MOVING**: If you left click and hold on the window bar you can MOVE by dragging the window.
	
**RESIZING** Right click and drag. It's a bit weird. I don't like it too much. I didn't invent it.
	
In my quest for maximum screen estate, window bar doesn't have the name of the application. It will be in the taskbar. You can put although you would have to make the window bar higher. It's commented near the end of the rc-lua file.
	
**Different layout modes-** i3 is "manual"... you have to choose where the next window will go, for me this is a pain in the ass. Awesome is automatic. You choose the layout you want (in the rc.lua only 3 are enabled, the rest commented out) and then you can drag or resize the windows around.
	
### About the themes

They were made to be broken, and even though there are two of them, they are practically the same file with minor color, font, margins and wallpaper tweaks.

### About TAGS     
	 
Tags are "desktops". Desktops are an illusion.

You assign programs to "tags" (1)(2)(3)(4)(5) and with lain/lcpz you can even create/destroy/rename and reorder them dynamically without having to edit the .lua files.

When you choose a "desktop" you're really just showing apps with that tag. You can even combine them selecting more than one at the same time.
     
You assign a program to a tag with: Win + shift + tag number.
	 
Well, keep that in mind: That those little numbers are not desktops, but tags. They don't have to be numbers either, but out of the box are only configured via keyboard from 1 to 9 (and only show 5). You can probably program it so other combinations correspond to more tags/screens.

**Multiscreen:** I would have loved to investigate multiscreen. I'm sure you can create different bars on different screens and assign tags to specific monitors and stuff. I know there is a key combination to move apps to screens but I don't know what tag it goes to. Or if you consider both monitors  part of a big layout that shows a tag.