# Oh-My-Zsh (deployed by 05_ohmyzsh.sh)
# IMPORTANT: ZSH_THEME and plugins MUST be set BEFORE sourcing oh-my-zsh.sh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
  git
  gitignore
  extract
  redis-cli
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Agnoster theme customization (must be AFTER source oh-my-zsh.sh)
CURRENT_FG='white'

prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.) "
  fi
}
