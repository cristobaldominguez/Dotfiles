# Brew-installed tool configs (deployed by 06_brew_packages.sh)

# mise (version manager)
eval "$(/opt/homebrew/bin/mise activate zsh)"

# gnu-sed (use as default sed)
PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"

# fzf (fuzzy finder)
eval "$(fzf --zsh)"

# bat (better cat)
export BAT_THEME=Dracula
