cp -asvb ~/.dotfiles/wsl/.profile.d/20_wsl_base ~/.dotfiles/wsl/.profile.d/21_wsl_ssh_agent ~/.profile.d/

if confirm "Update wsl.conf? (you'll need to relaunch wsl)? [y/n]: "; then
  sudo cp ~/.dotfiles/wsl/etc/wsl.conf /etc/wsl.conf
fi

if confirm "Installing ssh startup on launch? [y/n]: "; then
  sudo apt -y purge openssh-server
  sudo apt -y install openssh-server
  sudo cp --preserve=mode ~/.dotfiles/wsl/usr/local/bin/start_ssh /usr/local/bin/
  sudo cp ~/.dotfiles/wsl/etc/sudoers.d/start_ssh /etc/sudoers.d/
  sudo /usr/local/bin/start_ssh
  cp -asvb ~/.dotfiles/wsl/.profile.d/22_wsl_ssh_server ~/.profile.d/
fi

if confirm "Installing gnome-terminal? [y/n]: "; then
  sudo apt -y install dbus-x11 gnome-terminal
  sudo systemd-machine-id-setup
  cp -asvb ~/.dotfiles/wsl/.profile.d/90_wsl_gnome_terminal ~/.profile.d/
  echo "NOTE: Make sure you've installed VcXsrv - https://sourceforge.net/projects/vcxsrv/"
fi

if confirm "Set chrome.exe as launcher for gnome-terminal? [y/n]: "; then
  sudo apt -y install libglib2.0-bin
  # Copy chrome.desktop
  cp -asvb ~/.dotfiles/wsl/.local ~/
  gio mime x-scheme-handler/http chrome.desktop
  gio mime x-scheme-handler/https chrome.desktop
fi

if confirm "Install minikube.exe helpers ssh/minikube-env/mount? [y/n]: "; then
  cp -asvi ~/.dotfiles/wsl/bin/minikube-env ~/bin/
  cp -asvi ~/.dotfiles/wsl/bin/minikube-mount ~/bin/
  cp -asvi ~/.dotfiles/wsl/bin/minikube-mount-sshfs ~/bin/
  cp -asvi ~/.dotfiles/wsl/.ssh/config.d/minikube ~/.ssh/config.d/
  echo 'NOTE: Install choco/minikube on Windows'
  echo 'NOTE: Add windows user to "Hyper-V Administrators"'
fi
