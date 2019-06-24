
# Set DISPLAY and autolaunch gnome-term
append_file ~/.profile "source ~/.dotfiles/wsl/.profile.append"

echo "Updatine wsl.conf (you'll need to relaunch wsl)"
sudo cp ~/.dotfiles/wsl/wsl.conf /etc/wsl.conf
