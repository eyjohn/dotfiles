#!/bin/bash
echo "Installing dotfiles"

BASE="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -L ~/.dotfiles ]; then
  echo "Adding .dotfiles link"
  ln -s "$BASE" ~/.dotfiles
fi

function symlink_file {
  source=$1
  target=$2
  if [ -f $target ]; then
    echo "$target exists, moving to $target.bak"
    mv $target $target.bak 2>/dev/null
  fi
  echo "Adding link to $source"
  ln -s $source $target
}

function append_file {
  target=$1
  cmd="$2"
  if ! grep -q "$cmd" $target; then
    echo "Appending $cmd to $target"
    echo "$cmd" >> $target
  fi
}

function confirm {
  read -p "$1" -n 1 -r && echo && [[ $REPLY =~ ^[Yy]$ ]]
  return $?
}

# Symlink all included base files
LINK_FILES=(.gitconfig .gitignore_global .bash_aliases)
for file in ${LINK_FILES[@]}; do
  symlink_file ~/.dotfiles/$file ~/$file
done

# Force colour mode on ubuntu .bashrc
if grep -q '#force_color_prompt=yes' ~/.bashrc; then 
  echo "Patching .bashrc to force_color_prompt=yes"
  sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc
fi

# Create bin
if [ ! -d bin ]; then
  echo "Creating ~/bin"
  mkdir -p ~/bin
fi

# WSL Specifics
if grep -q Microsoft /proc/version; then
  echo "Detected WSL Environment"
  source $BASE/wsl/install.sh
fi
