$version = "0.3.3"

# Load Configuration File here

echo @"
---------------------------------------------------------

Windows Public Limited Sync Script

Version: $version

--------------------------------------------------------
"@


########################################################

# Run Checks here


########################################################

# --------------------------
#  Windows Explorer Settings
# --------------------------

echo @"

# Updating Windows Explorer Settings

- Turning on Dark Mode
- Enable Transparency
- Show Hidden Files
- Show File Extensions
- Hide the Status Bar
- Show All Folders
- Minimize the Ribbon
- ShowInfoTip

---

"@


$hkcu = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion"

$path = "$hkcu\Themes\Personalize"

echo @"

# Personalizing Windows Theme

$path

"@

echo "Turning on Dark Mode"
Set-ItemProperty -Path $path -Name AppsUseLightTheme -Value 0

echo "Enabling Transparency"
Set-ItemProperty -Path $path -Name EnableTransparency -Value 1

########################################################


$path = "$hkcu\Explorer\Advanced"

echo @"

# Advanced Explorer Preferences

$path
"@


Set-ItemProperty -Path $path -Name Hidden -Value 1
Set-ItemProperty -Path $path -Name HideFileExt -Value 0
Set-ItemProperty -Path $path -Name ShowSuperHidden -Value 1

echo @"

# Ribbon Preferences

$path
"@

Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon -Name ExplorerRibbonStartsMinimized -Value 1

echo @"

# ---------------------------------------

# Status Bar Preferences

# ---------------------------------------
$path
"@

#### START Set Desktop Background  ####################################

# Set Desktop Background 

# This is still broken

# NOTE: 

# Look into taking a random file out of 
# my github share repo and then running
# through photopea with some javascript
# and create dark monotone versions for 
# desktop backgrounds\

# Note (EVEN MORE COOL):

# What would even be more cool is setting
# in the config.yml file a few parameters
# such as color, darkness, saturation
# and then running those into photopea
# as parameters....
###################################

# echo "making a wallpapers folder"
# $path = "$HOME\Pictures\Wallpapers"

# if (-not(Test-Path $path)) {
#    mkdir $HOME\Pictures\Wallpapers
# }

# echo "downloading wallpaper to ~\Pictures\Wallpapers\desktop.jpg"

# wget https://raw.githubusercontent.com/8rents/_/i/Wallpapers/san-francisco/dark-monotones/cyan-sid-verma-k-LCaf7TOD8-unsplash.jpg -OutFile $HOME\Pictures\Wallpapers\desktop.jpg
`
# Get-ChildItem -name -Path "$HOME\Pictures\Wallpapers\desktop.jpg"

# Set-ItemProperty -path "HKCU:\Control Panel\Desktop\" -name wallpaper -value $HOME\Pictures\Wallpapers\desktop.jpg

# echo "Restarting explorer.exe"
# cmd.exe /c "taskkill.exe /f /im explorer.exe && start explorer.exe"

#### END Set Desktop Background  ####################################


#################################
# Install Scoop
#################################

echo @"

No USB Detected | Running in Cloud Mode

Installing Scoop to: 

$HOME\scoop

---------------------------------------------------------

"@

# Check first if using a USB, this only checks the default install location.

if (-not(Test-Path -Path "$HOME\scoop")) {
   Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
   scoop update
   scoop update *
   scoop status
}


########################################################


echo @"

Preliminary Installs (via scoop):

- git (used for installing and managing application packages, both for Windows& PowerShell
- powershell-yaml (for reading our yml config file)
- glow (used for supplying terminal feedback in Markdown)

"@

scoop install git glow powershell-yaml

########################################################

# Load in config.yml

########################################################

echo @"

# Loading the `config.yml` file into the env variable $env:config

# How to use the envormental yml config

All you need to do work directly with the local $config variable

Then at the end of the script, convert the string back to yaml and 
reassign it to the env variable

`$env:config = $config | ConvertTo-Yaml`

"@

$env:config = (Get-Content -Raw Sync\config.yml | Out-String)

echo "Setting the config file as the local variable $config"
$config = $env:config | ConvertFrom-Yaml



########################################################

# Explorer pereferences

########################################################

# --------------------------
#  Typora Prefs
# --------------------------

echo @"

# Cloning Typora Preferences

- **Sources:** [8rents/Typora](https://github.com/8rents/Typora)
- **Install Location:** ~\AppData\Roaming\Typora"

"@

git clone https://github.com/8rents/Typora $HOME\AppData\Roaming\Typora

########################################################

# --------------------------
#  Installing Scoop apps
# --------------------------

echo @"

---

# Installing Windows & Powershell apps via `scoop`:

- `typora` - Beautiful markdown editor)
- `vcredist2022` - A bucket or library recommended by starship amonst others
- `starship` - Newer command prompt (need to get nerd fonts properly automated)
- `windows-terminal` - A decent termianl emulator)
- `msys2` - Linux kludge with bash and pacman)
- `github` - GitHub Desktop, GUI Based git versioning
- `lazygit` - alternative cli for git
- `vscode` - Modern IDE (that isn't working half the time)
- `sublime-text` - Halfway Modern Editor (incase VScode isn't working)
- `sublime-merge` - Git client for sublime text
- `eza` (based on `exa` [`ls` replacement])
- `psfzf` (PowerShell wrapper around FZF)
- `autojump` - CLI tool that remembers the directories you've been to the most.
- `nodejs` - Server side javascript development (installs npm [package manager])
- `python` - Python programming language (installs pip package manager)
- `neofetch` - neat little terminal util to displa system info

---

"@ | glow -

scoop bucket add extras
scoop install typora vcredist2022 starship windows-terminal msys2 github lazygit vscode sublime-text sublime-merge eza psfzf autojump nodejs python

echo @"

# Getting Docker Installed

- `docker` - The base package to build containers on
- `docker-compose` - handy utlity to be able to manage containers with compose.yml files
- `dockercompletion` - autocomplete for docker
- `lazydocker` - Like `lazygit` but `lazydocker`

"@

scoop install docker docker-compose dockercompletion lazydocker


# --------------------------
# Git Prefs
# --------------------------

echo @" 

# Cloning Git Config

- **Source:** [8rents/git](https://github.com/8rents/git)
- **Install Location:** ~\.config\git

"@ | glow -

git clone https://github.com/8rents/git $HOME\.config\git


########################################################


# --------------------------
# PowerShell Profiles
# --------------------------

echo @" 

# Cloning PowerShell Profiles

- **Source:** [8rents/powershell](https://github.com/8rents/powershell)
- **Install Location:** ~\Documents\WindowsPowerShell

"@ | glow -


git clone https://github.com/8rents/powershell $HOME\Documents\WindowsPowerShell


########################################################

# --------------------------
#  Windows Term Prefs
# --------------------------

echo @"

# Cloning Windows Terminal Preferences

- **Source:** [8rents/Windows-Terminal](https://github.com/8rents/Windows-Terminal)
- **Install Location:** ~\scoop\apps\windows-terminal\current\settings

"@

git clone https://github.com/8rents/Windows-Terminal $HOME\scoop\apps\windows-terminal\current\settings



########################################################

# --------------------------
#  vsCode Prefs
# --------------------------

echo @"

# Cloning vsCode Preferences

- **Sources:** [8rents/vscode](https://github.com/8rents/vscode)
- **Install Location:** ~\scoop\apps\vscode\current\data


"@

git clone https://github.com/8rents/vscode $HOME\scoop\apps\vscode\current\data

########################################################

# --------------------------
#  Opening Apps
# --------------------------


echo @"

# Opening Apps from `~\scoop\apps` directory:

- GitHub @ github\current\GitHubDesktop.exe
- vsCode @ vscode\current\Code.exe
- Typora @ typora\current\Typora.exe
- Terminal @ windows-terminal\current\WindowsTerminal.exe

"@ | glow -

ii "$HOME\scoop\apps\github\current\GitHubDesktop.exe"
ii "$HOME\scoop\apps\vscode\current\Code.exe"
ii "$HOME\scoop\apps\windows-terminal\current\WindowsTerminal.exe"
ii "$HOME\scoop\apps\typora\current\Typora.exe"

echo @"

# Re-encodiong YAML config

Adding any changes to the local config back to the 
global env variable. Encoded as YAML

**Note:** that this will only be available within PowerShell
The actual `config.yml` file is not overwritten. 

It's basically read-only. 

"@

$env:config = $config | ConvertTo-Yaml