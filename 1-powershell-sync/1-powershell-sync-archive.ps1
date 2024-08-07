$version = "0.3.5"
$modified = "Monday, March 18, 2024 @ 11:16:43 AM"

# Note: These values will be writen to the config.yml on the next run

########################################################
############### Ephemeral Computing for: ###############
########### Windows Limited & Public Machines ##########
########### Part 1: A long PowerShell Script ###########
########################################################

# What to do after running this script?

# When this script finishes running, a Windows Terminal Bash Prompt will open up. Then you will need to run the 2-bash-sync.sh script in the Windows Terminal Window

########################################################

# Table of Contents / What does this script do?

# Line: 029 - Part 1: Control Checks
# Line: 128 - Part 2: Set up & Configuration
# Line: 156 - Part 3: Display the Welcome Message
# Line: 178 - Part 4: Windows Explorer Settings
# Line: 257 - Part 5: Cloning custom configs from GitHub
# Line: 666 - Part 6: Scoop Installs
# Line: 667 - Part 7: Finishing up

########################################################
########## Part 1: Control Checks ######################
########################################################

#############################################
# Check 1: Does the User have admin ??????
#############################################

# Test for admin function: A self contained function to test the current user to see if they have admin
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

###############################################
# Check #2: See if scoop is already installed
###############################################


# if the ~\scoop directory is not found we can assume scoop is not installed
if (-not(Test-Path -Path "$HOME\scoop")) {

# If scoop is not installed then Print a message explaining what we're installing

echo @"

Preliminary Installs (via scoop):

- `scoop` (PowerShell & Windows Package Manager)
- `git` (used for installing and managing application packages, both for Windows & PowerShell
- `powershell-yaml` (for reading our yml config file)
- `glow` (used for supplying terminal feedback in Markdown)

"@

# Otherwise, Install Scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# And then install the prerequiste apps
scoop install git glow powershell-yaml

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

###################################
# Check 3: Is the user using a USB?
###################################

# Need to implement this

########################################################
###### Part 2: Set up & Configuration ##################
########################################################
# Working with a yaml file



# Update some of the values in the hash table


########################################################
###### Part 3: Display THE Welcome Message #############
########################################################

echo @"

________________________________________________________

# WPL Sync Script

**Version:** $version 
**Updated On:** $modified
________________________________________________________

"@ | glow -


########################################################
###### Part 4: Windows Explorer Settings ########
#######
########################################################
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

"@ | glow -


$hkcu = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion"

$path = "$hkcu\Themes\Personalize"

echo @"

# Personalizing Windows Theme

$path

"@ | glow -

echo "- Turning on Dark Mode" | glow -
Set-ItemProperty -Path $path -Name AppsUseLightTheme -Value 0

echo "- Enabling Transparency" | glow
Set-ItemProperty -Path $path -Name EnableTransparency -Value 1

########################################################

$path = "$hkcu\Explorer\Advanced"

echo @"

# Advanced Explorer Preferences

- Show Hidden Files
- Show file Extensions
- Show system files

$path

"@ | glow -

Set-ItemProperty -Path $path -Name Hidden -Value 1
Set-ItemProperty -Path $path -Name HideFileExt -Value 0
Set-ItemProperty -Path $path -Name ShowSuperHidden -Value 1

##############################################

$path = "$hkcu\Explorer\Ribbon"

echo @"

# Ribbon Preferences

- Hide ribbon by default

$path

"@ | glow -

Set-ItemProperty -Path $path -Name ExplorerRibbonStartsMinimized -Value 1

##############################################

# Status bar prefs

# Set Desktop Background



########################################################
##### Part 5: Cloning custom configs from GitHub #######
########################################################

echo @"

# Cloning Preferences from GitHub

- Typora
- Git
- PowerShell
- Windows Terminal
- vsCode
- Bash Config (msys2) 
- ZSH Config (msys2) 

"@ | glow -


# --------------------------
#  Typora Prefs
# --------------------------


echo @"

# Cloning Typora Preferences from GitHub

- **Sources:** [8rents/Typora](https://github.com/8rents/Typora)
- **Install Location:** ~\AppData\Roaming\Typora"

"@ | glow -

git clone https://github.com/8rents/Typora $HOME\AppData\Roaming\Typora

########################################################


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

"@ | glow -

git clone https://github.com/8rents/Windows-Terminal $HOME\scoop\apps\windows-terminal\current\settings



########################################################

# --------------------------
#  vsCode Prefs
# --------------------------

echo @"

# Cloning vsCode Preferences

- **Sources:** [8rents/vscode](https://github.com/8rents/vscode)
- **Install Location:** ~\scoop\apps\vscode\current\data


"@ | glow -

git clone https://github.com/8rents/vscode $HOME\scoop\apps\vscode\current\data


# --------------------------
# Bash Configuration
# --------------------------

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



# --------------------------
# # Install all the Windows files and programs
# --------------------------

echo @"

---

# Installing Windows & PowerShell apps via Scoop:

- `typora` - Beautiful markdown editor
- `vcredist2022` - A bucket or library recommended by starship amonst others
- `starship` - Newer command prompt (need to get nerd fonts properly automated)
- `windows-terminal` - A decent terminal emulator
- `msys2` - Linux kludge with bash and Pacman
- `github` - GitHub Desktop, GUI Based git versioning
- `lazygit` - alternative cli for git
- `vscode` - Modern IDE (that isn't working half the time)
- `sublime-text` - Halfway Modern Editor (incase vsCode isn't working)
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

"@ | glow - 

scoop bucket add extras
scoop install typora vcredist2022 starship oh-my-posh windows-terminal msys2 github lazygit vscode sublime-text sublime-merge eza psfzf autojump nodejs yarn pnpm python neofetch electrum



########################################################
############### Part 7: Finishing up ###################
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
# ii "$HOME\scoop\apps\vscode\current\Code.exe"
ii "$HOME\scoop\apps\windows-terminal\current\WindowsTerminal.exe"
ii "$HOME\scoop\apps\typora\current\Typora.exe"

echo @"

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

@" | glow -