#!/bin/bash
echo "Installing dotfiles"

BASE="$( cd "$(dirname "$0")" ; pwd -P )"

# Symlink all included files
FILES=(.gitconfig .gitignore_global .bash_aliases)
for file in ${FILES[@]}; do
  mv $file $file.bak 2>/dev/null
  ln -s $BASE/$file ~/$file
done

# Force colour mode on ubuntu .bashrc
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc