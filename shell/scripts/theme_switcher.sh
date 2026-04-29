#!/usr/bin/env bash

themes=(
    "gruvbox"
    "gruvbox-material"
    "nord"
    "onedark"
    "kanagawa"
    "everforest"
    "dracula"
    "catppuccin-mocha"
    "alabaster"
    "solarized"
)

theme_colors(){
    theme="$1"
    case "$theme" in
        kanagawa)
            theme_color_bg=dcd7ba
            theme_color_fg=1f1f28
            echo "$theme_color_bg $theme_color_fg"
            return
            ;;
        gruvbox)
            theme_color_bg=fbf1c7
            theme_color_fg=282828
            echo "$theme_color_bg $theme_color_fg"
            ;;
        gruvbox-material)
            theme_color_bg=d4be98
            theme_color_fg=282828
            echo "$theme_color_bg $theme_color_fg"
            ;;
        everforest)
            theme_color_bg=a7c080
            theme_color_fg=272e33
            echo "$theme_color_bg $theme_color_fg"
            ;;
        catppuccin-mocha)
            theme_color_bg=b4befe
            theme_color_fg=1e1e2e
            echo "$theme_color_bg $theme_color_fg"
            ;;
        alabaster)
            theme_color_bg=777777
            theme_color_fg=323738
            echo "$theme_color_bg $theme_color_fg"
            ;;
        nord)
            theme_color_bg=81a1c1
            theme_color_fg=2e3440
            echo "$theme_color_bg $theme_color_fg"
            ;;
        onedark)
            theme_color_bg=abb2bf
            theme_color_fg=282c34
            echo "$theme_color_bg $theme_color_fg"
            ;;
        dracula)
            theme_color_bg=bd93f9
            theme_color_fg=282a36
            echo "$theme_color_bg $theme_color_fg"
            ;;
        solarized)
            theme_color_bg=a57705
            theme_color_fg=002b36
            echo "$theme_color_bg $theme_color_fg"
            ;;
    esac
}

hypr_theme_switcher(){
    theme="$1"
    read -r bg_color accent_color <<< "$(theme_colors "$theme")"
    old_line_1="col.active_border = rgb(.*)"
    old_line_2="col.inactive_border = rgb(.*)"
    new_line_1="col.active_border = rgb($bg_color)"
    new_line_2="col.inactive_border = rgb($accent_color)"

    sed -i "s|$old_line_1|$new_line_1|" "$CONFIG/hypr/conf/general.conf"
    sed -i "s|$old_line_2|$new_line_2|" "$CONFIG/hypr/conf/general.conf"
}


kitty_theme_switcher(){
    new_line="include $1.conf"
    old_line="include .*\.conf"

    sed -i "s|^$old_line|$new_line|" "$CONFIG"/kitty/kitty.conf
}

rofi_theme_switcher(){
    theme="$1"
    read -r accent_color bg_color<<< "$(theme_colors "$theme")"
    old_line_1="    bg0:				.*;"
    old_line_2="    fg0:				.*;"
    new_line_1="    bg0:				#$bg_color;"
    new_line_2="    fg0:				#$accent_color;"

    sed -i "s|^$old_line_1|$new_line_1|" "$CONFIG"/rofi/colors.rasi
    sed -i "s|^$old_line_2|$new_line_2|" "$CONFIG"/rofi/colors.rasi
}

dunst_theme_switcher(){
    old_line="foreground = \".*\""
    new_line=""

    sed -i "s|^$old_line|$new_line|g" "$CONFIG"/rofi/config.rasi
}

nvim_theme_switcher(){
	theme="$1"
	old_line="vim.cmd(\"colorscheme .*\")"
	new_line="vim.cmd(\"colorscheme $theme\")"

    sed -i "s|^$old_line|$new_line|g" "$CONFIG"/nvim/lua/tuxy.lua
}

qtile_theme_switcher(){
	theme="$1"
	old_line="from colorscheme import .*"
	new_line="from colorscheme import $theme"
    sed -i "s|^$old_line|$new_line|g" "$CONFIG"/qtile/config.py
	old_line="COLORSCHEME = .*"
	new_line="COLORSCHEME = $theme"
    sed -i "s|^$old_line|$new_line|g" "$CONFIG"/qtile/config.py
}

# TODO: Implement GTK Theme switching
# gtk_theme_switcher(){
#
# }

# TODO: Implement 
# gtk_theme_switcher(){
#
# }

theme_switch_launcher(){
    selected=$( printf "%s\n" "${themes[@]}" | sort | rofi -dmenu)
    [[ -n "$selected" ]] &&  theme_switcher "$selected"
}

theme_switcher(){
    theme="$1"
    hypr_theme_switcher "$theme"
    kitty_theme_switcher "$theme"
    rofi_theme_switcher "$theme"
    nvim_theme_switcher "$theme"
}
