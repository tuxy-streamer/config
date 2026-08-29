#!/usr/bin/env sh

create_note() {
	name=$(exec </dev/null; rofi -dmenu -p 'Enter name:' </dev/null)
	[ -n "$name" ] || return
	touch "$NOTES/$name.md" && nvim "$NOTES/$name.md"
}

rename_note() {
	old_name=$(find "$NOTES" -maxdepth 1 -mindepth 1 -type f | grep -v '.sc' | xargs -I {} basename {}  | cut -d '.' -f 1 | rofi -dmenu -p 'Select note:')
	[ -n "$old_name" ] || return
	new_name=$(exec </dev/null; rofi -dmenu -p 'Enter name:' </dev/null)
	[ -n "$new_name" ] || new_name=$old_name
	mv -- "$NOTES/$old_name.md" "$NOTES/$new_name.md"
}

delete_note() {
	name=$(exec </dev/null; rofi -dmenu -p 'Enter name:' </dev/null)
	[ -n "$name" ] || return
	trash "$NOTES/$name.md"
}

open_note() {
	name=$(find "$NOTES" -maxdepth 1 -mindepth 1 -type f | grep -v '.sc' | xargs -I {} basename {}  | cut -d '.' -f 1 | rofi -dmenu -p 'Select note:')
	[ -n "$name" ] || return
	win=$(tmux new-window -t Notes -P -F '#{window_index}')
	tmux send-keys -t "Notes:$win" "nvim $name.md" Enter
}

note_manage() {
	case "$1" in
		create) create_note ;;
		rename) rename_note ;;
		delete) delete_note ;;
		open)   open_note ;;
	esac
}

note_manage_launcher() {
	notes_menu_items='create rename delete open'
	selected=$(printf '%s\n' $notes_menu_items | rofi -dmenu -p 'Notes:')
	[ -n "$selected" ] || return
	cd Notes || return
	tmux has-session -t "Notes" 2>/dev/null || tmux new -s "Notes"
	note_manage "$selected"
}
