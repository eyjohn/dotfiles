# .dotfiles
These are my aliases, scripts and other defaults.
This is the first thing I install on a new environment.

## Installation

```sh
mkdir -p ~/git
cd ~/git
git clone https://github.com/eyjohn/dotfiles.git
cd dotfiles
./install.sh
```

## Windows Setup

Run as admin:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/eyjohn/dotfiles/main/windows.ps1'))
```
