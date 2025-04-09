#!/bin/bash

available_presets=("💻Single" "🏠Home")

if [ "$ROFI_RETV" == "0" ]; then
  # List available presets
  printf "%s\n" "${available_presets[@]}"
elif [ "$ROFI_RETV" == "1" ]; then
  # Run the selected preset
  case "$1" in
    "💻Single")
      xrandr --output eDP-1 --mode 1920x1080 --rate 144 --primary
      xrandr --output HDMI-1 --off
      sleep 1
      i3-msg restart > /dev/null
      ;;
    "🏠Home")
      xrandr --output HDMI-1 --mode 1920x1080 --rate 75 --primary
      xrandr --output eDP-1 --mode 1920x1080 --rate 144 --left-of HDMI-1
      sleep 1
      i3-msg restart > /dev/null
      ;;
    *)
      notify-send "Unknown preset: $1"
      ;;
  esac
fi
