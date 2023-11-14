#!/bin/bash

# Loop through command line options
# Set REBOOT flag if "--reboot" option is provided
# Set USE_REMOUNT flag if "--use_remount" option is provided
while getopts ":-:" o; do
    case "${OPTARG}" in
    reboot)
        REBOOT=1
        ;;
    use_remount)
        USE_REMOUNT=1
        ;;
    esac
done

# Root the device
adb wait-for-device root

# Unmount /system/bin and /system/etc if they are mounted on tmpfs
adb wait-for-device shell "mount | grep -q ^tmpfs\ on\ /system && umount -fl /system/{bin,etc} 2>/dev/null"

# Remount /system as read-write if --use_remount option is specified
if [[ "${USE_REMOUNT}" = "1" ]]; then
    adb wait-for-device shell "remount"
# Check if /system has 0 available blocks and exit with an error if so
elif [[ "$(adb shell stat -f --format %a /system)" = "0" ]]; then
    echo "ERROR: /system has 0 available blocks, consider using --use_remount"
    exit -1
# Otherwise, remount /system as read-write
else
    adb wait-for-device shell "stat --format %m /system | xargs mount -o rw,remount"
fi

# Remove existing ih8sn files from /system
if [ "$(adb shell find /system -name '*ih8sn*' | wc -l)" -gt 0 ]; then
    echo "Removing existing ih8sn files"
    adb wait-for-device shell "find /system -name *ih8sn* -delete"
else
    echo "No ih8sn files found"
fi
if [ "$(adb shell find /system -name '*props*' | wc -l)" -gt 0 ]; then
    echo "Removing existing props files"
    adb wait-for-device shell "find /system -name *props* -delete"
else
    echo "No props files found"
fi

# Reboot the device if --reboot option is specified
if [[ "${REBOOT}" = "1" ]]; then
    adb wait-for-device reboot
fi

read -r -p "Press any key to exit..." && exit
