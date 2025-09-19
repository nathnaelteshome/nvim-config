#!/bin/bash

# Additional System Power Optimizations for Hyprland
# Run this script once to apply system-wide power saving settings

echo "Applying additional power optimizations..."

# 1. Enable power-efficient networking
echo 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="wl*", RUN+="/usr/bin/iw dev %k set power_save on"' | sudo tee /etc/udev/rules.d/70-wifi-powersave.rules > /dev/null

# 2. USB autosuspend for power saving
echo 'ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"' | sudo tee /etc/udev/rules.d/50-usb-powersave.rules > /dev/null

# 3. SATA power management
echo 'ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", ATTR{link_power_management_policy}="med_power_with_dipm"' | sudo tee /etc/udev/rules.d/50-sata-powersave.rules > /dev/null

# 4. Audio power saving
echo 'options snd_hda_intel power_save=1' | sudo tee /etc/modprobe.d/audio-powersave.conf > /dev/null

# 5. Enable kernel power saving features
echo 'kernel.nmi_watchdog = 0' | sudo tee -a /etc/sysctl.d/99-powersave.conf > /dev/null
echo 'vm.dirty_writeback_centisecs = 6000' | sudo tee -a /etc/sysctl.d/99-powersave.conf > /dev/null
echo 'vm.laptop_mode = 5' | sudo tee -a /etc/sysctl.d/99-powersave.conf > /dev/null

# 6. Create power-aware systemd services
cat << 'EOF' | sudo tee /etc/systemd/system/powersave-tweaks.service > /dev/null
[Unit]
Description=Power saving tweaks
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'
ExecStart=/bin/bash -c 'echo 1500 > /proc/sys/vm/dirty_writeback_centisecs'
ExecStart=/bin/bash -c 'echo N > /sys/module/snd_hda_intel/parameters/power_save_controller'

[Install]
WantedBy=multi-user.target
EOF

# Enable the service
sudo systemctl enable powersave-tweaks.service 2>/dev/null

echo "Power optimizations applied! Reboot for full effect."
echo "Note: Some changes require root permissions and will prompt for password."