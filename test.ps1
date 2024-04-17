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

###############################################
# Check #1: See if scoop is already installed
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

# However if scoop is already installed 
# (if the ~\scoop directory is found then run updates and skip the rest)
} else {

echo @"

# Scoop & friends already installed, running update

"@ | glow -

# 1. First update scoop itself
scoop update

# 2. Update all apps installed with scoop
scoop update *

# 3. Print the status after all the updates have been applied
scoop status

}

#############################################
# Check 2: Does the User have admin ??????
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
{
# Admin is True

echo @"
________________________________________________________
    
So you're running this as admin... This script is mainly for peons who are running limited accounts on public boxes.

You might as well just install Linux Subsystem, Hyper terminal and get vscode syncing flawlessly."
        
Honestly, running Cmder terminal with msys bash and a kludged portable vscode will seem less than elegant compared to 
the power to actually use what you have.

Here's what I suggest...
    
`wsl --install`
    
That will install Linux subsystem

Now you're all set... That's much better than this kludge of a mess... 

Anyway, Have a nice day :)

________________________________________________________

"@ 

}

###################################
# Check 3: Is the user using a USB?
###################################

# Need to implement this

