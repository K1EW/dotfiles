xinput set-prop "ELAN0515:00 04F3:3142 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "ELAN0515:00 04F3:3142 Touchpad" "libinput Tapping Enabled" 1
setxkbmap -layout us,th -option grp:win_space_toggle
exec i3
