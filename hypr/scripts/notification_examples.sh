#!/bin/bash

# Beautiful Notification Examples and Quick Tests
# Source the main notification script
source ~/.config/hypr/scripts/beautiful_notifications.sh

# Demo function to showcase different notification types
demo_notifications() {
    echo "🎨 Showcasing Beautiful Hyprland Notifications..."
    sleep 1
    
    # Messaging app notifications
    telegram_notification "New Message" "Alice: Hey! How's your day going? 😊"
    sleep 2
    
    slack_notification "Channel Update" "#general: Meeting moved to 3 PM"
    sleep 2
    
    discord_notification "Voice Channel" "Friend joined Gaming Lounge"
    sleep 2
    
    whatsapp_notification "Group Message" "Family Chat: Dinner at 7 PM"
    sleep 2
    
    # System notifications
    success_notification "Build Complete" "Project compiled successfully"
    sleep 2
    
    warning_notification "Low Battery" "15% remaining - Please charge"
    sleep 2
    
    info_notification "System Update" "5 packages available for update"
    sleep 2
    
    # Media notifications
    spotify_notification "Now Playing" "Bohemian Rhapsody - Queen"
    sleep 2
    
    # Power notifications
    power_notification "performance"
    sleep 2
    
    echo "✨ Demo complete! Check out your beautiful notifications!"
}

# Quick test functions for specific apps
test_telegram() {
    telegram_notification "Test Message" "This is a Telegram-style notification! ✈️"
}

test_slack() {
    slack_notification "Test Channel" "This is a Slack-style notification! 💬"
}

test_discord() {
    discord_notification "Test Server" "This is a Discord-style notification! 🎮"
}

test_system() {
    success_notification "Test Complete" "System notification test successful! ✅"
}

test_power_modes() {
    echo "Testing power mode notifications..."
    power_notification "performance"
    sleep 1.5
    power_notification "balanced"
    sleep 1.5
    power_notification "powersave"
}

# Interactive menu
show_menu() {
    echo "🔔 Beautiful Hyprland Notifications - Test Menu"
    echo "=============================================="
    echo "1) Demo all notifications"
    echo "2) Test Telegram notification"
    echo "3) Test Slack notification"
    echo "4) Test Discord notification"
    echo "5) Test system notifications"
    echo "6) Test power mode notifications"
    echo "7) Custom notification"
    echo "8) Exit"
    echo ""
    read -p "Choose an option (1-8): " choice
    
    case $choice in
        1) demo_notifications ;;
        2) test_telegram ;;
        3) test_slack ;;
        4) test_discord ;;
        5) test_system ;;
        6) test_power_modes ;;
        7) custom_notification ;;
        8) echo "Goodbye! 👋"; exit 0 ;;
        *) echo "Invalid option. Please try again."; show_menu ;;
    esac
}

# Custom notification creator
custom_notification() {
    echo "Create a custom notification:"
    echo "Available types: telegram, slack, discord, whatsapp, signal, teams, gmail, spotify, youtube, success, warning, error, info, system"
    echo ""
    read -p "Notification type: " type
    read -p "Title: " title
    read -p "Message: " message
    read -p "Duration (ms, default 3000): " duration
    
    duration=${duration:-3000}
    
    show_notification "$type" "$title" "$message" "$duration"
    echo "✨ Custom notification sent!"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ $# -eq 0 ]]; then
        show_menu
    else
        case "$1" in
            "demo") demo_notifications ;;
            "telegram") test_telegram ;;
            "slack") test_slack ;;
            "discord") test_discord ;;
            "system") test_system ;;
            "power") test_power_modes ;;
            "menu") show_menu ;;
            *) echo "Usage: $0 [demo|telegram|slack|discord|system|power|menu]" ;;
        esac
    fi
fi