#!/bin/bash
echo "Installing dotfiles"

BASE="$( cd "$(dirname "$0")" ; pwd -P )"

source "$BASE/functions.sh"

if [ ! -L ~/.dotfiles ]; then
  echo "Adding .dotfiles link"
  ln -s "$BASE" ~/.dotfiles
fi

mkdir -m 0700 ~/.ssh

DIRS=(.profile.d/ bin/ .ssh/config.d .ssh/sockets)
mkdir -p ${DIRS[@]/#/~/}

TARGETS=(.bash_aliases .gitconfig .gitignore_global)
cp -asvb ${TARGETS[@]/#/~/.dotfiles/} ~/

# .ssh/config.d doesn't support backups
cp -asvi ~/.dotfiles/.ssh/config.d/github ~/.ssh/config.d/

[ ! -f ~/.ssh/config ] && echo > ~/.ssh/config # Add blank line for prepend to work
prepend_file ~/.ssh/config 'Include config.d/*'
insert_file ~/.profile 'for f in ~/.profile.d/*[^~]; do source $f; done'

# Force colour mode on ubuntu .bashrc
if grep -q '#force_color_prompt=yes' ~/.bashrc; then 
  echo "Patching .bashrc to force_color_prompt=yes"
  sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc
fi

# WSL Specifics
if grep -q Microsoft /proc/version; then
  echo "Detected WSL Environment"
  source $BASE/wsl/install.sh
fi
