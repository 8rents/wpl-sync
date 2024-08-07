# temp - import these from yml file

$name = "WPL Sync"
$description = "Synchronization Script for\n Windows Public Limited Computers"
$version = "0.3.5"
$modified = (ls .\test.ps1).LastWriteTime
$author = "8rents@gmail.com"

###################################
# Script welcome message
###################################

echo @"

____________________________________________

$name v$version 

Synchronization Script for 
Windows Public Limited Computers

Last updated on $modified by $author
____________________________________________

"@

###################################
# Test for admin
###################################

function Test-Administrator  
{  
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

# If the user is admin then display the message
# Otherwise if the user is not admin don't display anything and cruise right by
if(Test-Administrator)
{ Get-Content -Path .\user-is-oped.txt }

###################################
# INSTALL SCOOP
###################################

# if the ~\scoop directory is not found we can assume scoop is not installed
if (-not(Test-Path -Path "$HOME\scoop")) {

# If scoop is not installed then Print a message explaining what we're installing

echo @"

Preliminary Installs (via scoop):

- `scoop` (PowerShell & Windows Package Manager)
- `git` (used for installing and managing application packages, both for Windows & PowerShell
- `powershell-yaml` (for reading our yml config file)
- `glow` (used for supplying terminal feedback in Markdown)
- `winget` Microsoft Package Manager

"@

# Otherwise, Install Scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# And then install the prerequiste apps
scoop install git glow powershell-yaml winget

# Post install
scoop update   # update scoop itself
scoop update * # Update all apps installed with scoop
scoop status   # Print Status

# However if scoop is already installed 
# (if the ~\scoop directory is found then run updates and skip the rest)
} else {

echo @"

# Scoop & friends already installed, checking for updates

"@ | glow -

scoop update   # update scoop itself
scoop update * # Update all apps installed with scoop
scoop status   # Print Status

}


##################################
# 8rents Git Prefs
##################################

echo @" 

# Cloning Git Config

- **Source:** [8rents/git](https://github.com/8rents/git)
- **Install Location:** ~\.config\git

"@ | glow -

git clone https://github.com/8rents/git $HOME\.config\git

$git_user = git config user.name
$git_email = git config user.email

echo @"

-- Git config check --

username: $git_user
email: $git_email

-- end config check --

"@

###################################
# USB Check
###################################

echo "line 111: USB check functions will start here"

###################################
# Set up working with a YAML File
###################################

echo "line 117: Begin working with the YAML file in more depth here"

###################################
# Windows Explorer Settings
###################################

echo @"

# Updating Windows Explorer Settings

The following are the Windows Explorer settings that this script is currently changing:

- Turning on Dark Mode
- Enable Transparency
- Show Hidden Files
- Show File Extensions
- Hide the Status Bar
- Show All Folders
- Minimize the Ribbon
- ShowInfoTip

______________________________

"@ | glow -


$hkcu = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion"

$path = "$hkcu\Themes\Personalize"

echo @"
________________________________

# `\Themes\Personalize`

"@ | glow -

echo "Turning on Dark Mode"
Set-ItemProperty -Path $path -Name AppsUseLightTheme -Value 0

echo "Enabling Transparency"
Set-ItemProperty -Path $path -Name EnableTransparency -Value 1

########################################################


$path = "$hkcu\Explorer\Advanced"

echo @"
________________________________

# `\Explorer\Advanced`

"@ | glow -

echo "Showing hidden files"
Set-ItemProperty -Path $path -Name Hidden -Value 1
echo "Showing file extensions"
Set-ItemProperty -Path $path -Name HideFileExt -Value 0
echo "Showing system files and directories"
Set-ItemProperty -Path $path -Name ShowSuperHidden -Value 1

########################################################

$path = "$hkcu\Explorer\Ribbon"

echo @"
______________________________

# `\Explorer\Ribbon`

- Hiding ribbon by default

______________________________

# Additional settings to implement:

- Status bar prefs
- Set Desktop Background

______________________________

"@ | glow -

Set-ItemProperty -Path $path -Name ExplorerRibbonStartsMinimized -Value 1


# _____________________________________
#
#  End Windows Explorer Preferences
# _____________________________________



#  Typora Prefs

echo @"

# Cloning Typora Preferences from GitHub

- **Sources:** [8rents/Typora](https://github.com/8rents/Typora)
- **Install Location:** ~\AppData\Roaming\Typora"

"@ | glow -

git clone https://github.com/8rents/Typora $HOME\AppData\Roaming\Typora

# PowerShell Profiles

echo @" 

# Cloning PowerShell Profiles

- **Source:** [8rents/powershell](https://github.com/8rents/powershell)
- **Install Location:** ~\Documents\WindowsPowerShell

"@ | glow -


git clone https://github.com/8rents/powershell $HOME\Documents\WindowsPowerShell


#  Windows Term Prefs

echo @"

# Cloning Windows Terminal Preferences

- **Source:** [8rents/Windows-Terminal](https://github.com/8rents/Windows-Terminal)
- **Install Location:** ~\scoop\apps\windows-terminal\current\settings

"@ | glow - 

git clone https://github.com/8rents/Windows-Terminal $HOME\scoop\apps\windows-terminal\current\settings


#  vsCode Prefs

echo @"

# Cloning vsCode Preferences

Note: vsCode is not currently working. 

- **Sources:** [8rents/vscode](https://github.com/8rents/vscode)
- **Install Location:** ~\scoop\apps\vscode\current\data


"@ | glow - 

git clone https://github.com/8rents/vscode $HOME\scoop\apps\vscode\current\data



# Bash Configuration

echo @" 

# Cloning Bash Config

**Warning** - This script has to be run from the bash shell. Symlinks from PowerShell will not work.

## Configuration Details

- **Source:** [8rents/bash](https://github.com/8rents/bash)
- **Install Location:** /c/Users/sfplinternet/Settings/Shells/Bash
- **Symlink files to:** /c/Users/sfplinternet/

"@ | glow -

git clone https://github.com/8rents/bash $HOME\Settings\Shells\Bash

cd $HOME\Settings\Shells\Bash

# fetch all branches in the origin repo (GitHub)
git fetch origin

# switch to windows branch
git checkout -b windows origin/windows

# All Powershell and Windows apps


echo @"

---

# Installing Windows & Powershell apps via `scoop`:

- `typora` - Beautiful markdown editor
- `vcredist2022` - A bucket or library recommended by starship amonst others
- `starship` - Newer command prompt (need to get nerd fonts properly automated)
- `windows-terminal` - A decent termianl emulator
- `soulseekqt` - The SoulSeek File sharing network.
- `msys2` - Linux kludge with bash and pacman
- `github` - GitHub Desktop, GUI Based git versioning
- `lazygit` - alternative cli for git
- `vscode` - Modern IDE (that isn't working half the time)
- `sublime-text` - Halfway Modern Editor (incase VScode isn't working)
- `sublime-merge` - Git client for sublime text
- `eza` (based on `exa` [`ls` replacement])
- `psfzf` (PowerShell wrapper around FZF)
- `autojump` - CLI tool that remembers the directories you've been to the most.
- `nodejs` - Server side javascript development (installs npm [package manager])
- `yarn` - A slightly better package manager than npm
- `pnpm` - An even better package manager than `yarn`. PNPM downloads each dependency only one time making `node_modules` folders a helluva lot smaller.
- `python` - Python programming language (installs pip package manager)
- `neofetch` - neat little terminal util to display system info
- `electrum` - The best bitcoin wallet
- `oh-my-posh` - Better PowerShell Interface
---

"@ | glow -

scoop bucket add extras
scoop install typora vcredist2022 starship oh-my-posh windows-terminal msys2 github lazygit vscode sublime-text sublime-merge eza psfzf autojump nodejs yarn pnpm python neofetch electrum

###################################
# Installing Nerd Fonts
###################################

echo @"

Here are some resources to installing fonts automatically from PowerShell

- [Using Scoop to install Nerd Fonts(https://github.com/matthewjberger/scoop-nerd-fonts)
- [Nerd Font Official Installation method - Install.ps1](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-6-install-script)
- [SuperUser Guide to Installing Nerd Fonts with WinGet](https://superuser.com/questions/1765024/downloading-and-installing-fonts-using-powershell-commands-only)
- [A semi-shitty Medium article on Nerd Fonts in PowerShell](https://medium.com/@vedantkadam541/beautify-your-windows-terminal-using-nerd-fonts-and-oh-my-posh-4f4393f097)

"@ | glow - 

###################################
# Opening Apps
###################################


echo @"

# Opening Apps from `~\scoop\apps` directory:

- GitHub @ github\current\GitHubDesktop.exe
- vsCode @ vscode\current\Code.exe
- Typora @ typora\current\Typora.exe
- Terminal @ windows-terminal\current\WindowsTerminal.exe

"@ | glow -

ii "$HOME\scoop\apps\github\current\GitHubDesktop.exe"
# ii "$HOME\scoop\apps\vscode\current\Code.exe"
ii "$HOME\scoop\apps\windows-terminal\current\WindowsTerminal.exe"
ii "$HOME\scoop\apps\typora\current\Typora.exe"

echo @" | glow -

# Re-encodiong YAML config

Adding any changes to the local config back to the 
global env variable. Encoded as YAML

**Note:** that this will only be available within PowerShell
The actual `config.yml` file is not overwritten. 

It's basically read-only. 

"@ | glow -

# $env:config = $config | ConvertTo-Yaml



# --------------------------
# Current State of the Script Message
# For keeping myself updated about hwere I left off
# --------------------------

echo "@

# Current State of this PowerShell Script

## Critical issues to fix

### vsCode is not currently working. 

Steps to trying to fix vsCode:

1. Remove downloading and installing the prefs from GitHub (line: 326)
2. Install vsCode through winget

If these don't fix vsCode, then just use the web IDE for the time being.

Articles on the Subject

- [Using WinGet to Install Portable apps](https://github.com/microsoft/winget-cli/blob/master/doc/specs/%23182%20-%20Support%20for%20installation%20of%20portable%20standalone%20apps.md)

---

## Improvements to make

1. Install a Nerd Font and add it to the `~\Documents\.profile` to be used when script completes
2. Add program prefs to the `~\Documents\.profile` like: 
    - `eza` aka `ls` aliases
    - `fzf`
    - `jump`
3. Remove the entire Docker section

---

## PowerShell Configuration Articles

- [Helpful PowerShell Aliases](https://github.com/codenewa/helpful-alias-powershell)
- [RedHat Guide to using FZF]](https://redhat.com/sysadmin/fzf-linux-fuzzy-finder)

---

*Sally sells PowerShells by the sea shore*

@" | glow -