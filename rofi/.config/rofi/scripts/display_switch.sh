#!/usr/bin/env bash

MONITOR_CONFIG="$HOME/.config/hypr/monitors.conf"

# If no arguments are passed, list the available options for Rofi to display
if [ -z "$1" ]; then
    echo "💻 Laptop Only"
    echo "📺 Mirror Displays"
else
    # If an option is clicked/selected, execute the corresponding command
    case "$1" in
        "💻 Laptop Only")
            hyprctl keyword monitor "eDP-1, 1920x1200@60, 0x0, 1"
            hyprctl keyword monitor "HDMI-A-2, disable"

			echo 'monitor = eDP-1, 1920x1200@60, 0x0, 1' > "$MONITOR_CONFIG"
            echo 'monitor = HDMI-A-2, disable' >> "$MONITOR_CONFIG"
            ;;
        "📺 Mirror Displays")
            hyprctl keyword monitor "eDP-1, 1920x1080@60, 0x0, 1"
            hyprctl keyword monitor "HDMI-A-2, 1920x1080@75, 0x0, 1, mirror, eDP-1"
			
			echo 'monitor = eDP-1, 1920x1080@60, 0x0, 1' > "$MONITOR_CONFIG"
            echo 'monitor = HDMI-A-2, 1920x1080@75, 0x0, 1, mirror, eDP-1' >> "$MONITOR_CONFIG"
            ;;
    esac
	exec env OK_SELECTION=1 pkill rofi
fi
