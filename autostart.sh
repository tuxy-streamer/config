#!/usr/bin/env bash

touchpad_setup() {
    local touchpad="ELAN0787:00 04F3:321A Touchpad"
    xinput set-prop "$touchpad" "Synaptics Tap Action" 1 1 1 0 1 3 0
    xinput set-prop "$touchpad" "Synaptics Locked Drags" 1
    xinput set-prop "$touchpad" "Synaptics Two-Finger Scrolling" 1 0
    xinput set-prop "$touchpad" "Synaptics Edge Scrolling" 0 0 0
    xinput set-prop "$touchpad" "Synaptics Scrolling Distance" 90 90
    xinput set-prop "$touchpad" "Synaptics Click Action" 1 2 3
    xinput set-prop "$touchpad" "Device Accel Constant Deceleration" 2.5
}

gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" &
dunst &
otd-daemon &
syncthing &
blanket &
foot --server &

[[ "$XDG_SESSION_TYPE" == wayland ]] && \
	awww-daemon & \
	awww img "$HOME"/wallpapers/101010.png
[[ "$XDG_SESSION_TYPE" == x11 ]] && \
	touchpad_setup & \
	feh --bg-fill --borderless "$HOME"/wallpapers/101010.png & \
	setxkbmap -option caps:escape & \
	picom &
hypridle &
