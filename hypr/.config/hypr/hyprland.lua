local mainMod = "SUPER"
local terminal = "kitty"

-------------------------------
---- AUTOSTART ----
-------------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("easyeffects -w")
    hl.exec_cmd("dunst")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

-------------------------------
---- INCLUDES ----
-------------------------------
pcall(require, "monitors")

-------------------------------
---- GENERAL CONFIGURATION ----
-------------------------------
hl.config({
    input = {
        touchpad = {
            natural_scroll = true,
        },
        kb_layout = "us",
    },
    cursor = {
        no_warps = true,
    },
    general = {
        gaps_in = 1,
        gaps_out = 1,
        allow_tearing = true,
    },
    decoration = {
        rounding = 5,
    },
    group = {
        groupbar = {
            font_family = "sans",
            font_size = 14,
            font_weight_active = "bold",
            height = 16,
            gaps_in = 2,
            gradients = true,
            gradient_rounding = 3,
            indicator_height = 0,
            text_color = "rgb(3c3836)",
            text_color_inactive = "rgba(3c3836aa)",
            ["col.active"] = "rgb(ebdbb2)",
            ["col.inactive"] = "rgb(ebdbb2)",
        },
    },
})

-------------------------------
---- DEVICES ----
-------------------------------
hl.device({
    name = "2.4g-mouse",
    sensitivity = -0.4,
})

hl.device({
    name = "2.4g-mouse-1",
    sensitivity = -0.4,
})

-------------------------------
---- ANIMATIONS ----
-------------------------------
hl.curve("snappy", { type = "bezier", points = { { 0.1, 1 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "snappy", style = "slide" })

-------------------------------
---- BINDINGS ----
-------------------------------
-- Application Launchers & Core Actions
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall waybar && waybar"))
hl.bind("Print", hl.dsp.exec_cmd("hyprcap shot -s region -c"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("hyprlock"))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    -- Switch/Focus to workspace (e.g., SUPER + 1)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    -- Move active window to workspace (e.g., SUPER + SHIFT + 1)
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Focus Navigation
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))

-- Window Management
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l", group_aware = true}))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r", group_aware = true}))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d", group_aware = true}))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u", group_aware = true}))

-- Group Navigation
hl.bind(mainMod .. " + CTRL + H", hl.dsp.group.prev())
hl.bind(mainMod .. " + CTRL + L", hl.dsp.group.next())

-- Mouse Binds
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())

-- Media & Hardware Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

-- Switches
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("pidof hyprlock && systemctl suspend"), { locked = true })
