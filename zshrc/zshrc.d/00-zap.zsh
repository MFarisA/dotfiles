# Zap plugin manager + completions.
autoload -Uz compinit
compinit

eval "$(starship init zsh)"
#
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/exa"
plug "zap-zsh/vim"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/fzf"
plug "zap-zsh/sudo"