#!/usr/bin/env sh

cht(){
	selected_lang=$(curl cht.sh/:list | fzf)
	list_topic=$(curl cht.sh/"$selected_lang"/:list)
	[ -n "$list_topic" ] || curl cht.sh/"$selected_lang" | less -R && return
	selected_topic=$(echo "$list_topic" | fzf)
	curl cht.sh/"$selected_lang"/"$selected_topic" | less -R
}
