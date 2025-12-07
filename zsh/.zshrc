export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"

ZSH_THEME="robyrussel"

source $ZSH/oh-my-zsh.sh

plugins=(git zsh-syntax-highlighting zsh-autosuggestions z)

export NVM_LAZY_LOAD=true
source "$HOME/.zsh-nvm.zsh"

# inside tmux it uses zoxide to jump to directories, starts nvim and renames the tmux window
function zvim() {
  # go to the folder
  z $*

  # create a new tmux window if not in tmux
  if [ -z "$TMUX" ]; then
    tmux new-window
  fi
  # if not in tmux, create a new session
  if [ -z "$TMUX" ]; then
    tmux new-session
  fi
  
  tmux rename-window "$*"

  # run nvim in the current window
  tmux send-keys "nvim" C-m
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
