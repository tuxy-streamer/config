#!/usr/bin/env bash

tmux_startup() {
	local terminal="$1"
    tmux new-session -ds temp_session && tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh" && tmux kill-session -t temp_session
    $terminal --class=code -e tmux a -t "$(awk 'END {print $2}' "$HOME/.config/tmux/resurrect-store/last")" &
    $terminal --class=note -e tmux a -t "notes" &
}

tmux_open() {
    local selected=$1
    [[ -z "$selected" ]] && return 1

    local session_name
    session_name=$(basename "$selected")
    tmux has-session -t "$session_name" 2>/dev/null &&
        tmux attach -t "$session_name" ||
        tmux new-session -c "$selected" -s "$session_name"
}

bind -x '"\C-a": ( selected="$(zoxide query --list | fzf --height=40%)" && tmux_open "$selected" )'
bind -x '"\C-p": ( selected="$(find /storage/projects/repos -maxdepth 1 -mindepth 1 -type d | fzf)" && tmux_open "$selected" )'
