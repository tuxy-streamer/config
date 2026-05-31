#!/usr/bin/env sh

tmux_startup() {
	terminal="$1"
    tmux new-session -ds temp_session && tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh" && tmux kill-session -t temp_session
    $terminal --class=code -e tmux a -t "$(awk 'END {print $2}' "$HOME/.config/tmux/resurrect-store/last")" &
    $terminal --class=note -e tmux a -t "notes" &
}

tmux_open() {
    selected=$1
    [ -z "$selected" ] && return 1
    session_name=$(basename "$selected")
    tmux has-session -t "$session_name" 2>/dev/null &&
        tmux attach -t "$session_name" ||
        tmux new-session -c "$selected" -s "$session_name"
}

tmux_split(){
	direction=$1
	cmd=$2
	usage_msg="Usage: tmux_split <direction(h/v)> <cmd>"
	echo "$direction"
	echo "$cmd"
	[ -z "$direction" ] && echo "$usage_msg" && return
	[ -z "$cmd" ] && echo "$usage_msg" && return
	[ "$direction" = "h" ] && tmux split-window -h 
	[ "$direction" = "v" ] && tmux split-window 
	tmux send "$cmd" Enter
}


bind -x '"\C-a": ( selected="$(zoxide query --list | fzf --height=40%)" && tmux_open "$selected" )'
bind -x '"\C-p": ( selected="$(find $HOME/Projects/repos -maxdepth 1 -mindepth 1 -type d | fzf)" && tmux_open "$selected" )'
