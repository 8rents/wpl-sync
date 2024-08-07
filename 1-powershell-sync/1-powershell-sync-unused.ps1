echo @"

THIS FILE IS: 1-powershell-sync-unused

THIS IS THE COLLECTION OF SECTIONS OF THE SCRIPT THAT HAVE BEEN REMOVED.

There is no reason to run this directly

@" | glow -

exit


# BELOW THIS LINE THE SCRIPT WILL NOT RUN
# IT'S SIMPLY FOR ARCHIVAL PURPOSES
#___________________________________________________________________

# -------------------------------
# Installing Docker via PowerShell
# ------------------------------- 

echo @"
 
# Getting Docker Installed

Docker doesn't work without admin so this is pretty pointless..
 
- **docker** - The base package to build containers on
- **docker-compose** - handy utlity to be able to manage containers with compose.yml files
- **dockercompletion** - autocomplete for docker
- **lazydocker** - Like **lazygit** but **lazydocker**
 
"@ | glow -

scoop install docker docker-compose dockercompletion lazydocker