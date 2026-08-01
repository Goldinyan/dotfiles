
# Zsh Configuration with Zinit

# ========================================================================
# ZINIT SETUP
# ========================================================================

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"

# Load zinit
source "${ZINIT_HOME}/zinit.git/zinit.zsh"


# ========================================================================
# KEYBNINDS 
# ========================================================================

bindkey -e

bindkey "∏" history-search-backward  # altgr shift p
bindkey "›" history-search-backward # altgr shift n

# ========================================================================
# PLUGINS
# ========================================================================

# Syntax highlighting
# zinit ice depth=1
# zinit light zdharma-continuum/fast-syntax-highlighting

# Autosuggestions
zinit ice depth=1
zinit light zsh-users/zsh-autosuggestions

# Completions
zinit ice depth=1
zinit light zsh-users/zsh-completions

FAST_HIGHLIGHT_THEME=none

# ========================================================================
# THEME & PROMPT
# ========================================================================

eval "$(starship init zsh)"


# ========================================================================
# ENVIRONMENT & PATH
# ========================================================================

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

zstyle ':fast-syntax-highlighting:highlight' command 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' builtin 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' function 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' alias 'fg=#ffffff'
zstyle ':fast-syntax-highlighting:highlight' reserved-word 'fg=#ffffff'

zstyle ':fast-syntax-highlighting:highlight' unknown-token 'fg=#000000'
zstyle ':fast-syntax-highlighting:highlight' path 'fg=#b0b0b0'
   
