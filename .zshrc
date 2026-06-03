autoload -Uz compinit
compinit

#zstyle ':completion:*' menu select

# Tambahkan ini di baris paling akhir ~/.zshrc
#bindkey '^I' expand-or-complete

#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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

eval "$(starship init zsh)"
#
# Load and initialise completion system
#autoload -Uz compinit
#compinit

#alias 'crd'='composer run dev' \
#  'art'='php artisan' \
#  'crd'='composer run dev' \
#  'c'='composer' \
#  'mysql-up' = 'brew services start mysql' \
#  'mysql-down' = 'brew services stop mysql' \
#  'pgsql-up' = 'brew services start postgresql@18' \
#  'pgsql-down' = 'brew services stop postgresql@18' 
alias crd='composer run dev'
alias art='php artisan'
alias c='composer'
alias mysql-up='brew services start mysql'
alias mysql-down='brew services stop mysql'
alias pgsql-up='brew services start postgresql@18'
alias pgsql-down='brew services stop postgresql@18'
#alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias tinker='php artisan tinker'
alias optimize='php artisan optimize:clear && php artisan optimize'

function sail() {
    if [ "$1" = "optimize" ]; then
        shift
        sh $([ -f sail ] && echo sail || echo vendor/bin/sail) artisan optimize:clear
        sh $([ -f sail ] && echo sail || echo vendor/bin/sail) artisan optimize
        return
    fi

    sh $([ -f sail ] && echo sail || echo vendor/bin/sail) "$@"
}

migrate() {
  if [[ "$1" == "fresh" ]]; then
    shift
    php artisan migrate:fresh "$@"
  else
    php artisan migrate "$@"
  fi
}

docker() {
  if [[ "$1" == "up" ]]; then
    shift
    command docker compose -f docker/docker-compose.yml up -d --build "$@"

  elif [[ "$1" == "down" ]]; then
    shift
    command docker compose -f docker/docker-compose.yml down "$@"

  elif [[ "$1" == "restart" ]]; then
    shift
    command docker compose -f docker/docker-compose.yml restart "$@"

  else
    command docker "$@"
  fi
}

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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# Added by Antigravity
export PATH="/Users/rebecca/.antigravity/antigravity/bin:$PATH"


# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/rebecca/Library/Application Support/Herd/config/php/85/"

# Flutter
export PATH="$PATH:/Users/rebecca/Developer/flutter/flutter/bin"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

#export ANDROID_HOME=$HOME/Developer/flutter
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator



# Added by Antigravity IDE
export PATH="/Users/rebecca/.antigravity-ide/antigravity-ide/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/rebecca/.antigravity-ide/antigravity-ide/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/rebecca/.antigravity-ide/antigravity-ide/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/rebecca/.antigravity-ide/antigravity-ide/bin:$PATH"
