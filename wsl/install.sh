cp -asvb ~/.dotfiles/wsl/.profile.d/20_wsl_base ~/.profile.d/

if [ "$WSL_VERSION" == 1 ] && confirm "Update wsl.conf? (you'll need to relaunch wsl)? [y/n]: "; then
  sudo cp ~/.dotfiles/wsl/etc/wsl.conf /etc/wsl.conf
fi

if [ "$WSL_VERSION" == 2 ] && confirm "Fix /var/run/docker.sock permissions? [y/n]: "; then
  sudo usermod -aG docker ${USER}
fi

if [ "$WSL_VERSION" == 2 ] && confirm "Fix screen dir issue for user? [y/n]: "; then
  sudo usermod -aG docker ${USER}
  cp -asvb ~/.dotfiles/wsl/.profile.d/24_wsl_fix_screen ~/.profile.d/
fi

if has_apt; then
  if confirm "Installing ssh startup on launch? [y/n]: "; then
    sudo apt -y purge openssh-server
    sudo apt -y install openssh-server
    sudo cp --preserve=mode ~/.dotfiles/wsl/usr/local/bin/start_ssh /usr/local/bin/
    sudo cp ~/.dotfiles/wsl/etc/sudoers.d/start_ssh /etc/sudoers.d/
    sudo /usr/local/bin/start_ssh
    cp -asvb ~/.dotfiles/wsl/.profile.d/22_wsl_ssh_server ~/.profile.d/
  fi

  if confirm "Installing X11 Display support? [y/n]: "; then
    sudo apt -y install dbus-x11
    sudo systemd-machine-id-setup
    cp -asvb ~/.dotfiles/wsl/.profile.d/23_wsl_display ~/.profile.d/
    echo "NOTE: Make sure you've installed VcXsrv - https://sourceforge.net/projects/vcxsrv/"
  fi
fi