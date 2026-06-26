# ~/.zshrc

# --- History ---
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

HISTSIZE=200000
SAVEHIST=200000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

# --- Completion ---
fpath=(/usr/share/zsh/site-functions $fpath)

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "$(dirname "$ZSH_COMPDUMP")"

autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

# --- Keybindings ---
bindkey -e

# --- fzf ---
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# --- zsh plugins ---
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if (( $+functions[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# --- Aliases ---
alias upgrade='paru -Suy'

alias gst='git status'
alias gl='git log --oneline --decorate --graph --all'
alias gd='git diff'

alias grep='grep --color=auto'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group --icons=auto'
  alias ll='eza -lah --group --icons=auto --git'
  alias la='eza -la --group --icons=auto'
else
  alias ls='ls --color=auto'
  alias ll='ls -lah --color=auto'
  alias la='ls -la --color=auto'
fi

command -v bat >/dev/null 2>&1 && alias cat='bat'
command -v duf >/dev/null 2>&1 && alias df='duf'
command -v nvim >/dev/null 2>&1 && alias vi='nvim'

# --- Path ---
export LOCAL="$HOME/.local"
export PATH="$LOCAL/bin:$PATH"

# --- pyenv ---
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# --- Google Cloud SDK ---
if [[ -f "$HOME/.local/share/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/.local/share/google-cloud-sdk/path.zsh.inc"
fi

if [[ -f "$HOME/.local/share/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/.local/share/google-cloud-sdk/completion.zsh.inc"
fi

# --- Starship prompt ---
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# --- Commands ---
command -v fastfetch >/dev/null 2>&1 && fastfetch
