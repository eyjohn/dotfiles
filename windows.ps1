# Install Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Normal Web Access Software
choco install googlechrome googledrive zoom -y

# General software
choco install adobereader vlc -y

# Basic editing/navigating
choco install notepadplusplus 7zip -y

if ((Read-Host "Install Development Tools [y/n]") -match "^y"){
    # Install WSL
    wsl --install

    # Development Tools
    choco install docker-desktop vscode git -y
    choco install git --params "/WindowsTerminal /WindowsTerminalProfile" -y
}
