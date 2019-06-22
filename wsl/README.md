# WSL Setup

## Windows Mounts

`/etc/wsl.conf`

```
[automount]
enabled = true
root = /
options = "metadata,uid=1000,gid=1000,umask=22"
mountFsTab = false

# Enable DNS – even though these are turned on by default, we’ll specify here just to be explicit.
[network]
generateHosts = true
generateResolvConf = true
```

## SSH enabled/startable?

```sh
sudo apt remove openssh-server
sudo apt install openssh-server

sudo bash -c 'echo service ssh start > /usr/local/bin/start_ssh; chmod +x /usr/local/bin/start_ssh'

sudo visudo

# Append: %sudo ALL=NOPASSWD: /usr/local/bin/start_ssh
```

## Install VcXsrv

If I want any UIs:

https://sourceforge.net/projects/vcxsrv/

## Install gnome-terminal

```sh
sudo apt install dbus-x11
sudo apt install gnome-terminal
sudo systemd-machine-id-setup
```