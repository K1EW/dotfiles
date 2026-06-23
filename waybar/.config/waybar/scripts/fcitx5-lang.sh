#!/bin/bash
current_layout=$(fcitx5-remote -n 2>/dev/null)

case "$current_layout" in
    *"us"*)   echo "US" ;;
    *"th"*)   echo "TH" ;;
    "mozc")   echo "JP" ;;
    *)        echo "US" ;;
esac
