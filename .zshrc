export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="nordic-custom"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions z)

source $ZSH/oh-my-zsh.sh
source $HOME/.local/bin/env

# export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"

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
