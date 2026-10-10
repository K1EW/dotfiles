#!/usr/bin/env bash
set -e

MONITOR_CONFIG="$HOME/.config/hypr/monitors.lua"

# If no arguments are passed, list the available options for Rofi to display
if [ -z "$1" ]; then
    echo "💻 Laptop Only"
    echo "📺 Mirror Displays"
else
    # If an option is clicked/selected, execute the corresponding command
    case "$1" in
        "💻 Laptop Only")
            hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1 })'
            hyprctl eval 'hl.monitor({ output = "HDMI-A-2", disabled = true })'

            cat << 'EOF' > "$MONITOR_CONFIG"
hl.monitor({
    output = "eDP-1",
    mode = "1920x1200@60",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-2",
    disabled = true,
})
EOF
            ;;
        "📺 Mirror Displays")
            hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })'
            hyprctl eval 'hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@75", position = "0x0", scale = 1, mirror = "eDP-1" })'

            cat << 'EOF' > "$MONITOR_CONFIG"
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-2",
    mode = "1920x1080@75",
    position = "0x0",
    scale = 1,
    mirror = "eDP-1",
})
EOF
            # Reset the mirrored output to clear a stale cursor image.
            hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "off", monitor = "HDMI-A-2" }))'
            sleep 1
            hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "on", monitor = "HDMI-A-2" }))'
            ;;
    esac
    exec env OK_SELECTION=1 pkill rofi
fi
