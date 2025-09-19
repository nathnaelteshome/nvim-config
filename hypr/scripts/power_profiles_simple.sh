#!/bin/bash

# Simple Power Profile Switcher (no sudo required)
# Usage: ./power_profiles_simple.sh [performance|balanced|powersave]

PROFILE=${1:-balanced}

case $PROFILE in
    "performance")
        hyprctl keyword animations:enabled true
        hyprctl keyword decoration:blur:enabled true
        hyprctl keyword decoration:shadow:enabled true
        hyprctl keyword misc:vfr false
        hyprctl keyword misc:vrr 0
        ~/.config/hypr/scripts/beautiful_notifications.sh power "performance"
        ;;
        
    "balanced")
        hyprctl keyword animations:enabled false
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword decoration:shadow:enabled false
        hyprctl keyword misc:vfr true
        hyprctl keyword misc:vrr 2
        ~/.config/hypr/scripts/beautiful_notifications.sh power "balanced"
        ;;
        
    "powersave")
        hyprctl keyword animations:enabled false
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword decoration:shadow:enabled false
        hyprctl keyword misc:vfr true
        hyprctl keyword misc:vrr 2
        hyprctl keyword decoration:active_opacity 1.0
        hyprctl keyword decoration:inactive_opacity 1.0
        ~/.config/hypr/scripts/beautiful_notifications.sh power "powersave"
        ;;
        
    *)
        hyprctl notify 3 2000 "rgb(ff0000)" "Invalid power profile!"
        exit 1
        ;;
esac