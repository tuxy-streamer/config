set -o vi
export CONFIG="$HOME/.config"
export STORAGE="/storage"
export SCRIPTS="$CONFIG/shell/scripts"
export ZSH_PLUGINS="$CONFIG/shell/zsh-plugins"
export BOOK_LIBRARY="$STORAGE/personal/notes/library"

# Application config move to .config
export WINEPREFIX="$CONFIG/wine"
export W3M_DIR="$CONFIG/wine"

# Man
export MANPAGER="nvim +Man!"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH

# go
export PATH="$CONFIG/go/bin:$PATH"

# starship
if [ -n "$ZSH_VERSION" ]; then
  eval "$(starship init zsh)"
elif [ -n "$BASH_VERSION" ]; then
  eval "$(starship init bash)"
fi

# clipmenu
export CM_LAUNCHER=rofi

# zoxide
if [ -n "$ZSH_VERSION" ]; then
  eval "$(zoxide init zsh)"
elif [ -n "$BASH_VERSION" ]; then
  eval "$(zoxide init bash)"
fi

# pyenv
export PATH="$CONFIG/pyenv/bin:$PATH"
# if command -v pyenv >/dev/null 2>&1; then
#   # pyenv detects shell from environment, but guard just in case
#   eval "$(pyenv init --path)"
#   eval "$(pyenv init -)"
# fi
export PYTHON_ENV_ACTIVATE=false

# foundry
export PATH="$CONFIG/foundry/bin:$PATH"

# auto-completions
[[ -n "$ZSH_VERSION" ]] && autoload -U compinit && compinit

# uv
export PATH="/home/tuxy/.local/share/../bin:$PATH"
