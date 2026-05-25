#!/bin/bash

DIR="$1" # Takes l, d, u, or r
WIN_INFO=$(hyprctl activewindow -j)

# Check how many windows are in the current group
GROUP_LEN=$(echo "$WIN_INFO" | jq -r '.grouped | length // 0')

if [ "$GROUP_LEN" -gt 1 ]; then
    ADDRESS=$(echo "$WIN_INFO" | jq -r '.address')
    INDEX=$(echo "$WIN_INFO" | jq -r ".grouped | index(\"$ADDRESS\")")

    if [ "$DIR" = "l" ]; then
        if [ "$INDEX" -eq 0 ]; then
            # At the first tab: moving left detaches it from the group
            hyprctl --batch "dispatch moveoutofgroup ; dispatch movewindow l"
        else
            # Not at the edge: shift tab to the left
            hyprctl dispatch movegroupwindow b
        fi
    elif [ "$DIR" = "r" ]; then
        LAST_INDEX=$((GROUP_LEN - 1))
        if [ "$INDEX" -eq "$LAST_INDEX" ]; then
            # At the last tab: moving right detaches it from the group
            hyprctl --batch "dispatch moveoutofgroup ; dispatch movewindow r"
        else
            # Not at the edge: shift tab to the right
            hyprctl dispatch movegroupwindow f
        fi
    else
        # Up/Down movements inside a group default to standard behavior
        hyprctl --batch "dispatch moveoutofgroup ; dispatch movewindow $DIR"
    fi
else
    # Not in a group: use standard window/group movement
    hyprctl dispatch movewindoworgroup "$DIR"
fi
