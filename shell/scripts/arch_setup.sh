#!/usr/bin/env sh
logdir="$HOME/log/"
mkdir $logdir
js="nodejs npm pnpm bun prettier"
go="go"
rust="rustup cargo"
db="postgres mongodb"
env="fzf ripgrep fd neovim rofi dunst qtile hyprland"
terminal="xterm foot"

check_permission() {
	[ "$(id -u)" -ne 0 ] && echo "This script must be run as root." && return
}

noconfirm_pacman="pacman --noconfirm"

chaotic_aur() {
	sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com </dev/tty 2>&1 | tee -a "$logdir/$logfile"
	sudo pacman-key --lsign-key 3056513887B78AEB </dev/tty 2>&1 | tee -a "$logdir/$logfile"
	sudo $noconfirm_pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' </dev/tty 2>&1 | tee -a "$logdir/$logfile"
	sudo $noconfirm_pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' </dev/tty 2>&1 | tee -a "$logdir/$logfile"
	printf 'Success: Chaotic aur key signed\n' | tee -a "$logdir/$logfile"
	grep -q '^\s*\[chaotic-aur\]' /etc/pacman.conf ||
		printf '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n' | sudo tee -a /etc/pacman.conf >/dev/null
	printf 'Success: Chaotic aur added to pacman.conf\n' | tee -a "$logdir/$logfile"
}

aur_setup() {
	logfile="aur_setup_$(date -u +%Y-%m-%dT%H:%M:%S).log"
	touch "$logdir/$logfile" | tee -a "$logdir/$logfile"
	printf 'Success: Created log file %s/%s\n' "$logdir" "$logfile" | tee -a "$logdir/$logfile"
	chaotic_aur
	sudo $noconfirm_pacman -Syu | tee -a "$logdir/$logfile"
	command -v paru >/dev/null 2>&1 && printf 'Success: Found ' | tee -a "$logdir/$logfile" ||
		sudo $noconfirm_pacman -S paru | tee -a "$logdir/$logfile"
}
