#!/usr/bin/env bash

# TODO: Implement the commented options
power_menu_items=(
	"shutdown"
	"reboot"
	"login"
	"logout"
	# "sleep"
	# "hibernate"
)

powermenu(){
    selected=$( printf "%s\n" "${power_menu_items[@]}" | sort | rofi -dmenu)
    [[ -n "$selected" ]] || return
	case "$selected" in
		"shutdown")
			poweroff
			;;
		"reboot")
			poweroff --reboot
			;;
		"login")
			login
			;;
		"logout")
			logout
			;;
		"suspend")
			command ...
			;;
		"hibernate")
			command ...
			;;
	esac
}
