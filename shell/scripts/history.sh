#!/usr/bin/env sh

clear_unwanted_hist() {
	sed -i '/clear/d' "$HISTFILE"
	sed -i '/exit/d' "$HISTFILE"
}
