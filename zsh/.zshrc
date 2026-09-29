# ========================================================================
# ZINIT SETUP
# ========================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

[ -f "$ZDOTDIR/env" ] && source "$ZDOTDIR/env"

# ========================================================================
# PLUGINS
# ========================================================================

# is like lazy, makes big plugins load delayed, so your shell starts faster
zinit light romkatv/zsh-defer

zinit ice depth=1
zinit light zsh-users/zsh-completions

# interactive fzf menu with bat as preview
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:complete:*' fzf-preview 'bat --color=never --style=numbers --line-range=:500 $realpath 2>/dev/null || lsd --color=always $realpath'

zinit ice depth=1
zinit light zsh-users/zsh-autosuggestions

# looks if you have that as an alias and suggests to use it instead of typing the full command
zinit light MichaelAquilina/zsh-you-should-use

# shows a notification when a long-running command finishes
zinit light MichaelAquilina/zsh-auto-notify

# double esc to add sudo at the beginning of the command line
zinit snippet OMZP::sudo

# Syntax Highlighting must be loaded last
zinit ice depth=1
zinit light zsh-users/zsh-syntax-highlighting

FAST_HIGHLIGHT_THEME=none

# ========================================================================
# AUTOCOMPLETION & MENU CYCLING
# ========================================================================

zmodload zsh/complist

autoload -U compinit && compinit

zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

bindkey -M menuselect '^I' menu-complete
bindkey -M menuselect '^[[Z' reverse-menu-complete

# ========================================================================
# THEME & PROMPT
# ========================================================================

eval "$(starship init zsh)"

# ========================================================================
# ENVIRONMENT & PATH
# ========================================================================

export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$HOME/.config/zsh/scripts:$PATH"
export TERM="xterm-256color"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Zoxide
eval "$(zoxide init zsh)"

# Homebrew paths
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# Local bins
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.spicetify"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# ========================================================================
# BACKGROUND SERVICES / SCRIPTS
# ========================================================================

pgrep -f "serve.*3333" > /dev/null || nohup serve "$HOME/.config/zsh/startpage" -l 3333 >/dev/null 2>&1 &
[ -f "$HOME/.config/zsh/scripts/start_skhd.sh" ] && source "$HOME/.config/zsh/scripts/start_skhd.sh"

# ========================================================================
# ALIASES
# ========================================================================

[ -f "$ZDOTDIR/aliases" ] && source "$ZDOTDIR/aliases"

# ========================================================================
# SHELL OPTIONS
# ========================================================================

HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPEND_HISTORY
setopt sharehistory
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups 
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ========================================================================
# SYNTAX HIGHLIGHTING COLORS - Black & White Only
# ========================================================================

typeset -A ZSH_HIGHLIGHT_STYLES

# Gültige Befehle (Hellweiß / Fett)
ZSH_HIGHLIGHT_STYLES[command]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=white,bold'

# Ungültige Befehle (Dunkelgrau / Schwarz)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#444444'

# Pfade und Argumente
ZSH_HIGHLIGHT_STYLES[path]='fg=#b0b0b0'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#b0b0b0'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#b0b0b0'

zstyle ':fast-syntax-highlighting:highlight' command 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' builtin 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' function 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' alias 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' reserved-word 'fg=#ffffff'

zstyle ':fast-syntax-highlighting:highlight' unknown-token 'fg=#000000'
zstyle ':fast-syntax-highlighting:highlight' path 'fg=#b0b0b0' 

# ========================================================================
# KODA MONOCHROME LS COLORS
# ========================================================================

export LS_COLORS="di=34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;43:tw=30;42:ow=34;42"
export CLICOLOR=1

alias ls='lsd --color=always --icon=auto'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
