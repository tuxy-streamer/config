#!/usr/bin/env sh

cd() {
    builtin cd "$@" || return 1
    [ -d ".venv" ] && [ -z "$VIRTUAL_ENV" ] && . .venv/bin/activate && echo "Activated python .venv"
    [ ! -d ".venv" ] && [ -n "$VIRTUAL_ENV" ] && type deactivate >/dev/null 2>&1 && deactivate && echo "Deactivated python .venv"
	return 0
}

z() {
    dir=$(zoxide query "$@")
	cd "$dir" || return 1
	return
}
