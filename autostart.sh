#!/usr/bin/env bash

touchpad_setup() {
  touchpad="ELAN0787:00 04F3:321A Touchpad"
  xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
  xinput set-prop "$touchpad" "libinput Tapping Drag Enabled" 1
  xinput set-prop "$touchpad" "libinput Tapping Drag Lock Enabled" 1
  xinput set-prop "$touchpad" "libinput Tapping Button Mapping Enabled" 1 0
  xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
  xinput set-prop "$touchpad" "libinput Disable While Typing Enabled" 1
  xinput set-prop "$touchpad" "libinput Clickfinger Button Mapping Enabled" 1 0
  xinput set-prop "$touchpad" "libinput Horizontal Scroll Enabled" 1
  xinput set-prop "$touchpad" "libinput Middle Emulation Enabled" 1
  xinput set-prop "$touchpad" "libinput Accel Speed" 0.3
}

gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" &
dunst &
otd-daemon &
syncthing &
blanket &
foot --server &

[[ "$XDG_SESSION_TYPE" == wayland ]] && \
	awww-daemon & \
	awww img "$HOME"/Wallpaper/blackmount.png
[[ "$XDG_SESSION_TYPE" == x11 ]] && \
  touchpad_setup & \
  feh --bg-fill --borderless "$HOME"/Wallpaper/blackmount.png & \
  setxkbmap -option caps:escape & \
  picom &
