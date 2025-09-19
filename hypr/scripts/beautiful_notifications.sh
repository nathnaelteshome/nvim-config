#!/bin/bash

# Beautiful Hyprland Notifications Script
# Modern notification system with app-specific styling inspired by Telegram, Slack, Discord, etc.

# Color definitions
declare -A COLORS=(
    ["telegram"]="rgb(0,136,204)"     # Telegram blue
    ["slack"]="rgb(74,21,75)"         # Slack purple
    ["discord"]="rgb(88,101,242)"     # Discord blurple
    ["whatsapp"]="rgb(37,211,102)"    # WhatsApp green
    ["signal"]="rgb(58,134,255)"      # Signal blue
    ["teams"]="rgb(109,120,204)"      # Teams purple
    ["gmail"]="rgb(234,67,53)"        # Gmail red
    ["spotify"]="rgb(29,185,84)"      # Spotify green
    ["youtube"]="rgb(255,0,0)"        # YouTube red
    ["success"]="rgb(46,160,67)"      # Success green
    ["warning"]="rgb(255,149,0)"      # Warning orange
    ["error"]="rgb(255,59,48)"        # Error red
    ["info"]="rgb(0,122,255)"         # Info blue
    ["system"]="rgb(142,142,147)"     # System gray
)

# Icon definitions (Unicode symbols)
declare -A ICONS=(
    ["telegram"]="✈️"
    ["slack"]="💬"
    ["discord"]="🎮"
    ["whatsapp"]="📱"
    ["signal"]="🔒"
    ["teams"]="👥"
    ["gmail"]="📧"
    ["spotify"]="🎵"
    ["youtube"]="📺"
    ["success"]="✅"
    ["warning"]="⚠️"
    ["error"]="❌"
    ["info"]="ℹ️"
    ["system"]="⚙️"
    ["message"]="💬"
    ["call"]="📞"
    ["notification"]="🔔"
    ["battery"]="🔋"
    ["volume"]="🔊"
    ["brightness"]="☀️"
    ["network"]="🌐"
    ["bluetooth"]="📶"
)

# Notification urgency levels
declare -A URGENCY=(
    ["low"]=0
    ["normal"]=1
    ["critical"]=2
    ["urgent"]=3
)

# Function to show beautiful notification
show_notification() {
    local app_type="$1"
    local title="$2"
    local message="$3"
    local duration="${4:-3000}"
    local urgency_level="${5:-normal}"
    
    # Get color and icon for app type
    local color="${COLORS[$app_type]:-${COLORS[info]}}"
    local icon="${ICONS[$app_type]:-${ICONS[notification]}}"
    local urgency="${URGENCY[$urgency_level]:-1}"
    
    # Format the notification text with icon and styling
    local formatted_message="$icon $title${message:+: $message}"
    
    # Show notification with hyprctl
    hyprctl notify "$urgency" "$duration" "$color" "fontsize:12 $formatted_message"
}

# Function to show app-specific notifications
telegram_notification() {
    show_notification "telegram" "$1" "$2" "${3:-4000}" "${4:-normal}"
}

slack_notification() {
    show_notification "slack" "$1" "$2" "${3:-3500}" "${4:-normal}"
}

discord_notification() {
    show_notification "discord" "$1" "$2" "${3:-3500}" "${4:-normal}"
}

whatsapp_notification() {
    show_notification "whatsapp" "$1" "$2" "${3:-4000}" "${4:-normal}"
}

signal_notification() {
    show_notification "signal" "$1" "$2" "${3:-4000}" "${4:-normal}"
}

teams_notification() {
    show_notification "teams" "$1" "$2" "${3:-3500}" "${4:-normal}"
}

gmail_notification() {
    show_notification "gmail" "$1" "$2" "${3:-4000}" "${4:-normal}"
}

spotify_notification() {
    show_notification "spotify" "$1" "$2" "${3:-2500}" "${4:-low}"
}

youtube_notification() {
    show_notification "youtube" "$1" "$2" "${3:-3000}" "${4:-normal}"
}

# System notifications
success_notification() {
    show_notification "success" "$1" "$2" "${3:-2500}" "${4:-normal}"
}

warning_notification() {
    show_notification "warning" "$1" "$2" "${3:-4000}" "${4:-urgent}"
}

error_notification() {
    show_notification "error" "$1" "$2" "${3:-5000}" "${4:-critical}"
}

info_notification() {
    show_notification "info" "$1" "$2" "${3:-3000}" "${4:-normal}"
}

system_notification() {
    show_notification "system" "$1" "$2" "${3:-2500}" "${4:-low}"
}

# Power mode notifications with enhanced styling
power_notification() {
    local mode="$1"
    local duration="${2:-3000}"
    
    case "$mode" in
        "performance")
            show_notification "system" "Performance Mode" "High performance enabled" "$duration" "normal"
            ;;
        "balanced")
            show_notification "system" "Balanced Mode" "Balanced power profile active" "$duration" "normal"
            ;;
        "powersave")
            show_notification "system" "Power Save Mode" "Battery optimization enabled" "$duration" "normal"
            ;;
    esac
}

# Battery notifications
battery_notification() {
    local percentage="$1"
    local status="$2"
    local duration="${3:-3000}"
    
    if [[ "$status" == "Charging" ]]; then
        show_notification "system" "Battery Charging" "${percentage}% - Plugged in" "$duration" "low"
    elif [[ "${percentage%\%}" -le 20 ]]; then
        show_notification "warning" "Low Battery" "${percentage}% remaining" "$duration" "urgent"
    elif [[ "${percentage%\%}" -le 10 ]]; then
        show_notification "error" "Critical Battery" "${percentage}% - Charge now!" "$duration" "critical"
    else
        show_notification "system" "Battery Status" "${percentage}% remaining" "$duration" "low"
    fi
}

# Volume notifications
volume_notification() {
    local volume="$1"
    local is_muted="$2"
    local duration="${3:-2000}"
    
    if [[ "$is_muted" == "true" ]]; then
        show_notification "system" "Volume Muted" "Audio output disabled" "$duration" "low"
    else
        show_notification "system" "Volume" "${volume}%" "$duration" "low"
    fi
}

# Brightness notifications
brightness_notification() {
    local brightness="$1"
    local duration="${2:-2000}"
    
    show_notification "system" "Brightness" "${brightness}%" "$duration" "low"
}

# Network notifications
network_notification() {
    local network_name="$1"
    local status="$2"
    local duration="${3:-3000}"
    
    case "$status" in
        "connected")
            show_notification "success" "Network Connected" "Connected to $network_name" "$duration" "normal"
            ;;
        "disconnected")
            show_notification "warning" "Network Disconnected" "Lost connection to $network_name" "$duration" "urgent"
            ;;
        "connecting")
            show_notification "info" "Connecting" "Connecting to $network_name..." "$duration" "normal"
            ;;
    esac
}

# Workspace notifications with beautiful styling
workspace_notification() {
    local workspace_name="$1"
    local workspace_number="$2"
    local duration="${3:-1500}"
    
    # Custom colors for different workspaces
    local workspace_colors=(
        "rgb(255,99,71)"    # 1 - Tomato
        "rgb(60,179,113)"   # 2 - Medium Sea Green
        "rgb(30,144,255)"   # 3 - Dodger Blue
        "rgb(255,140,0)"    # 4 - Dark Orange
        "rgb(186,85,211)"   # 5 - Medium Orchid
        "rgb(255,20,147)"   # 6 - Deep Pink
        "rgb(0,206,209)"    # 7 - Dark Turquoise
        "rgb(255,215,0)"    # 8 - Gold
        "rgb(50,205,50)"    # 9 - Lime Green
        "rgb(138,43,226)"   # 10 - Blue Violet
    )
    
    local color_index=$((workspace_number - 1))
    local color="${workspace_colors[$color_index]:-rgb(100,149,237)}"
    
    hyprctl notify 1 "$duration" "$color" "fontsize:14 🖥️ Workspace $workspace_number: $workspace_name"
}

# Media notifications
media_notification() {
    local action="$1"
    local title="$2"
    local artist="$3"
    local duration="${4:-2500}"
    
    case "$action" in
        "play")
            show_notification "spotify" "Now Playing" "$title - $artist" "$duration" "low"
            ;;
        "pause")
            show_notification "spotify" "Paused" "$title - $artist" "$duration" "low"
            ;;
        "next")
            show_notification "spotify" "Next Track" "$title - $artist" "$duration" "low"
            ;;
        "previous")
            show_notification "spotify" "Previous Track" "$title - $artist" "$duration" "low"
            ;;
    esac
}

# Screenshot notifications
screenshot_notification() {
    local type="$1"
    local location="$2"
    local duration="${3:-3000}"
    
    case "$type" in
        "screen")
            show_notification "success" "Screenshot Saved" "Full screen captured" "$duration" "normal"
            ;;
        "window")
            show_notification "success" "Window Captured" "Window screenshot saved" "$duration" "normal"
            ;;
        "region")
            show_notification "success" "Region Captured" "Selected area screenshot saved" "$duration" "normal"
            ;;
    esac
}

# Usage examples and help
show_help() {
    echo "Beautiful Hyprland Notifications Script"
    echo "Usage examples:"
    echo ""
    echo "App notifications:"
    echo "  $0 telegram 'New Message' 'John Doe: Hello there!'"
    echo "  $0 slack 'Meeting Reminder' 'Team standup in 5 minutes'"
    echo "  $0 discord 'Voice Channel' 'Friend joined General'"
    echo ""
    echo "System notifications:"
    echo "  $0 success 'Task Complete' 'Build finished successfully'"
    echo "  $0 warning 'Low Disk Space' '85% disk usage'"
    echo "  $0 error 'Connection Failed' 'Unable to reach server'"
    echo ""
    echo "Special functions:"
    echo "  $0 power performance"
    echo "  $0 battery 85 Charging"
    echo "  $0 volume 75 false"
    echo "  $0 workspace 'TELEGRAM' 3"
    echo ""
}

# Main script logic
main() {
    if [[ $# -eq 0 ]] || [[ "$1" == "help" ]] || [[ "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    
    local function_name="${1}_notification"
    
    # Check if function exists
    if declare -f "$function_name" > /dev/null; then
        shift
        "$function_name" "$@"
    else
        # Fallback to generic notification
        show_notification "$@"
    fi
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi