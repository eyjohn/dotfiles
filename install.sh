#!/bin/bash
echo "Installing dotfiles"

BASE="$( cd "$(dirname "$0")" ; pwd -P )"

source "$BASE/functions.sh"

if [ ! -L ~/.dotfiles ]; then
  echo "Adding .dotfiles link"
  ln -s "$BASE" ~/.dotfiles
fi

DIRS=(.profile.d/ bin/)
mkdir ${TARGETS[@]/#/~/}

TARGETS=(.bash_aliases .gitconfig .gitignore_global)
cp -asvb ${TARGETS[@]/#/~/.dotfiles/} ~/

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
