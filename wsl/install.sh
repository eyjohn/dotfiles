
# Set DISPLAY and autolaunch gnome-term
append_file ~/.profile "source ~/.dotfiles/wsl/.profile.append"

if confirm "Update wsl.conf? (you'll need to relaunch wsl)? [y/n]: "; then
  sudo cp ~/.dotfiles/wsl/etc/wsl.conf /etc/wsl.conf
fi

if confirm "Installing ssh startup on launch? [y/n]: "; then
  sudo apt -y purge openssh-server
  sudo apt -y install openssh-server
  sudo cp ~/.dotfiles/wsl/usr/local/bin/start_ssh /usr/local/bin/
  sudo cp ~/.dotfiles/wsl/etc/sudoers.d/start_ssh /etc/sudoers.d/
  sudo /usr/local/bin/start_ssh
fi

if confirm "Installing gnome-terminal? [y/n]: "; then
  sudo apt -y install dbus-x11 gnome-terminal
  sudo systemd-machine-id-setup
  echo "NOTE: Make sure you've installed VcXsrv - https://sourceforge.net/projects/vcxsrv/"
fi