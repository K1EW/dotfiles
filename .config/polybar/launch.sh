#!/usr/bin/env bash
# Kill existing polybar instances
killall polybar

# Wait for the processes to terminate
sleep 1

# Launch polybar on each monitor
for monitor in $(xrandr --listmonitors | grep -oP '\S+' | tail -n +2); do
    MONITOR=$monitor polybar --reload main &
done

