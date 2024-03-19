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

# Line: 385 - Part 1: Preliminary Installs 
# Line: 037 - Part 2: Control Checks
# Line: 015 - Part 3: Set up & Configuration 
# Line: 415 - Part 4: Windows Explorer Settings
# Line: 665 - Part 5: Cloning custom configs from GitHub
# Line: 666 - Part 6: Scoop Installs
# Line: 667 - Part 7: Finishing up


########################################################
######## Part 1: Preliminary Installs  #################
########################################################


###########################
# Is Scoop Installed ??????
###########################

##############
# What's happening here?
#############

# If $HOME\scoop is not found then:
####### 1. Show a message
####### 2. Download Scoop
####### 3. Install git glow powershell-yaml via scoop
# else 
####### 1. Run  Scoop some updates
####### 2. Exit 

if (-not(Test-Path -Path "$HOME\scoop")) {

echo @"

Preliminary Installs (via scoop):

- Scoop (PowerShell & Windows Package Manager)
- git (used for installing and managing application packages, both for Windows & PowerShell
- powershell-yaml (for reading our yml config file)
- glow (used for supplying terminal feedback in Markdown)

"@

Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install git glow powershell-yaml

} else {

# If the $HOME\scoop folder is found, 
#### then run updates and skip the rest
   
scoop update
scoop update *
scoop status

}

#________________________________________________________


########################################################
########## Part 2: Control Checks ######################
########################################################


###########################
# Does the User have admin ??????
###########################

##############
# What's happening here?
#############

# Use the test-admin function
####### if the user is admin
############## print message
############## and exit
####### otherwise proceed as normal


# Test for admin function
function Test-Administrator  
{  
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

# If the user is not admin then display the message
if(Test-Administrator)
{

echo @"

________________________________________________________
"@ 

echo @"
    
So you're running this as admin... This script is mainly for peons who are running limited accounts on public boxes.

You might as well just install Linux Subsystem, Hyper terminal and get vscode syncing flawlessly."
        
Honestly, running Cmder terminal with msys bash and a kludged portable vscode will seem less than elegant compared to 
the power to actually use what you have.

Here's what I suggest...
    
`wsl --install`
    
That will install Linux subsystem

Now you're all set... That's much better than this kludge of a mess... 

Anyway, Have a nice day :)

"@

echo @"
________________________________________________________


"@ 

} else {
    # no admin
}



########################################################
###### Part 3: Set up & Configuration ###############
########################################################
# What goes on here? Read the yaml file in and then output it back to a different yaml file 


###########################
# Import and begin working with the YAML?
###########################

##############
# What's happening here?
#############

# the config.yml gets imported




########################################################
####### Part 2 Set Up & Configuration ##################
########################################################

# read the yaml file as a siple string
# Load the RAW config file into the local $config var
$config = (Get-Content -Raw Sync\config.yml | Out-String)

# Store the values as YAML (Not plain text) in the environmental varible
$env:config = $config | ConvertTo-Yaml

# new convert the enviormental variable to a has table and reassign to the local variable
$config = $env:config | ConvertFrom-Yaml


# Update some of the values in the hash table
$config.modfied = $modifed
$config.version = $version

# now that some values have been updated re-convert the hash table to 
# YAML and reassign the local variable to the environemental variable
$env:config = $config | ConvertTo-Yaml

# write the updated environemental var to the config file
Out-File -FilePath .\new-config.yml -InputObject $env:config -Encoding UTF8




########################################################
###### Part 4: Windows Explorer Settings ###############
########################################################



# Instructions

# the environmental variable should always be yaml
# the local variable can be whatever format is needed
# the file config.yml is only written from the enviornmental



# 2.  All you need to do work directly with the local $config variable. Then at the end of the script, convert the string back to yaml and  reassign it to the env variable



# Load Configuration File here

echo @"

---------------------------------------------------------

Welcome to:

Windows Public Limited Sync Script

You are currently running version: $version

--------------------------------------------------------

"@







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

"@


# --------------------------
#  Typora Prefs
# --------------------------


echo @"

# Cloning Typora Preferences from GitHub

- **Sources:** [8rents/Typora](https://github.com/8rents/Typora)
- **Install Location:** ~\AppData\Roaming\Typora"

"@

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


echo @" 

# Cloning Bash Config

- **Source:** [8rents/bash](https://github.com/8rents/bash)
- **Install Location:** ~\

**Note:* Bash configs are by default created in `$HOME` aka /home/sfplinternet/*

- './.bashrc' -> '$HOME/.bashrc'
- './.bash_logout' -> '$HOME/.bash_logout'
- './.bash_profile' -> '$HOME/.bash_profile'
- './.profile' -> '$HOME/.profile'

"@ | glow -

git clone https://github.com/8rents/bash $HOME\Settings\Shells\Bash


# fetch windows branch

# switch to windows branch

# symlink all the files!!

# link bash rc file
# rc.bash .bashrc

# link bash lougout
# logout.bash .bash_logout

# LINK BASH POFILE
# profile.bash .bash_profile


# link general profile
# profile.sh .profile


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