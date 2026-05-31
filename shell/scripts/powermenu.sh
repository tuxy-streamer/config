#!/usr/bin/env sh

# TODO: Implement the commented options.
# BUG: Login and Logout might now work as intended.
powermenu(){
	power_menu_items="shutdown reboot login logout sleep hibernate"
    selected=$( printf "%s\n" $power_menu_items | sort | rofi -dmenu)
    [ -n "$selected" ] || return
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
