if confirm "Enable symlinks support? (you need windows developer mode enabled) [y/n]: "; then
  cp -asvb ~/.dotfiles/mingw/.profile.d/20_win_symlinks ~/.profile.d/
fi