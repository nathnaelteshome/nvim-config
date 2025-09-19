#!/bin/bash

# Hyprland Power Profile Switcher with System-Wide Power Management
# Usage: ./power_profiles.sh [performance|balanced|powersave]

PROFILE=${1:-balanced}

case $PROFILE in
    "performance")
        echo "Switching to Performance Mode..."
        # Visual effects
        hyprctl keyword animations:enabled true
        hyprctl keyword decoration:blur:enabled true
        hyprctl keyword decoration:shadow:enabled true
        hyprctl keyword misc:vfr false
        hyprctl keyword misc:vrr 0
        hyprctl keyword decoration:blur:passes 3
        
        # CPU Performance
        echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null 2>&1
        
        # TLP Performance profile
        sudo tlp ac 2>/dev/null
        
        hyprctl notify 3 2000 "rgb(00ff00)" "Performance Mode Active"
        ;;
        
    "balanced")
        echo "Switching to Balanced Mode..."
        # Visual effects
        hyprctl keyword animations:enabled false
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword decoration:shadow:enabled false
        hyprctl keyword misc:vfr true
        hyprctl keyword misc:vrr 2
        hyprctl keyword decoration:blur:passes 2
        
        # CPU Balanced (let TLP decide)
        sudo tlp-stat -s > /dev/null 2>&1
        
        hyprctl notify 3 2000 "rgb(ffaa00)" "Balanced Mode Active"
        ;;
        
    "powersave")
        echo "Switching to Power Save Mode..."
        # Visual effects
        hyprctl keyword animations:enabled false
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword decoration:shadow:enabled false
        hyprctl keyword misc:vfr true
        hyprctl keyword misc:vrr 2
        hyprctl keyword decoration:blur:passes 1
        hyprctl keyword decoration:active_opacity 1.0
        hyprctl keyword decoration:inactive_opacity 1.0
        
        # CPU Power Save
        echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null 2>&1
        
        # TLP Battery profile
        sudo tlp bat 2>/dev/null
        
        # Additional power savings
        # Reduce screen brightness (if possible)
        brightnessctl set 30% 2>/dev/null
        
        hyprctl notify 3 2000 "rgb(0088ff)" "Power Save Mode Active"
        ;;
        
    *)
        echo "Usage: $0 [performance|balanced|powersave]"
        echo "Current profiles:"
        echo "  performance - All effects enabled, CPU performance mode"
        echo "  balanced    - Some effects disabled, TLP auto-mode"
        echo "  powersave   - All effects disabled, maximum battery life"
        exit 1
        ;;
esac