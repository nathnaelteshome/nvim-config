#!/bin/bash

if pgrep -x "waybar" >/dev/null; then
  pkill -USR1 waybar
else
  waybar -c ~/.config/hypr/Waybar-3.0/config -s ~/.config/hypr/Waybar-3.0/style.css &
fi
