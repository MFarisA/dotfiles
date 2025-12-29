# # Created by Zap installer
eval "$(starship init zsh)"
#
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/exa"
plug "zap-zsh/vim"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/fzf"
plug "zap-zsh/sudo"
#
# Load and initialise completion system
autoload -Uz compinit
compinit

alias 'crd'='composer run dev' \
  'art'='php artisan' \
  'crd'='composer run dev' \
  'c'='composer'

# Herd injected PHP binary.
export PATH="/Users/rebecca/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/rebecca/Library/Application Support/Herd/config/php/84/"

# bun completions
[ -s "/Users/rebecca/.bun/_bun" ] && source "/Users/rebecca/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


export PATH=$PATH:$(go env GOPATH)/bin


# Herd injected NVM configuration
export NVM_DIR="/Users/rebecca/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/
