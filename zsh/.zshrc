export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"

# ZSH_THEME="robbyrussell"
ZSH_THEME="eastwood"

source $ZSH/oh-my-zsh.sh

plugins=(git zsh-syntax-highlighting zsh-autosuggestions z)

export NVM_LAZY_LOAD=true
source "$HOME/.zsh-nvm.zsh"

# inside tmux it uses zoxide fuzzy finder to jump to directories, starts nvim and renames the tmux window
function zvim() {
  local dir
  dir=$(zoxide query -l | fzf --height 40% --reverse --preview 'eza -la --icons --git --color=always {}')
  
  if [ -z "$dir" ]; then
    return 0
  fi

  cd "$dir"

  # if not in tmux, create a new session
  if [ -z "$TMUX" ]; then
    tmux new-session -c "$dir" -n "$(basename "$dir")" "nvim"
    return
  fi
  
  tmux rename-window "$(basename "$dir")"
  nvim
}

function killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port>"
    return 1
  fi

  local pid=$(lsof -ti:$1)
  if [ -n "$pid" ]; then
    kill -9 $pid
    echo "Killed process on port $1 (PID: $pid)"
  else
    echo "No process found on port $1"
  fi
  return 0
}

# opencode
export PATH=/Users/jrobe/.opencode/bin:$PATH

eval "$(atuin init zsh)"
export ATUIN_FILTER_MODE=directory

export MYVIMRC="$HOME/.config/nvim/init.lua"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"

# fuzzy find zoxide directories
function zf() {
  local dir
  dir=$(zoxide query -l | fzf --height 40% --reverse --preview 'eza -la --icons --git --color=always {}')
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

# ssh into hosts from ~/.ssh/config using fzf
function zssh() {
  local host
  host=$(grep -E "^Host " ~/.ssh/config | awk '{print $2}' | grep -vE "github\.com|bitbucket\.org" | fzf --height 40% --reverse)
  
  if [ -z "$host" ]; then
    return 0
  fi

  # if in tmux, rename window to host
  if [ -n "$TMUX" ]; then
    tmux rename-window "$host"
  fi

  ssh "$host"
}

# eza aliases
alias ls='eza -l --icons --git'
alias ll='eza -la --icons --git'
alias la='eza -a --icons --git'
alias python='python3'
alias pip='pip3'
