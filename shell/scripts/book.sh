#!/usr/bin/env sh

open_book() {
	books=$(find "$BOOK_LIBRARY" -type f  | sed 's|.*/||; s|\.pdf$||')
	selected=$( echo "$books" | rofi -dmenu)
	[ -n "$selected" ] && zathura "$(find "$BOOK_LIBRARY" -type f | grep "${selected}\.pdf$")"
}
