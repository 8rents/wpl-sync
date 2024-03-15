# Windows Public Limited Sync Script

> ***The following script syncs ephemeral Windows computers that have no access to admin and are Publioc Machines***

----

## How to use

1. Open up a PowerShell instance
2. Set all script execution policies to bypassfor the current user (So that we can run arbitrary scripts in PowerShell)
 ```PowerShell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
 ```
3. Run the `1-powershell-sync.ps1` script. 
   *In the same directory just hit `1` and then `tab`*
4. After the script has completed running a Windows Terminal window will open with the msys2 bash shell. *Type:* `2` and then hit `tab` and `enter` to run the `2-bash-sync.sh` script.
5. After the bash script has completed, Open up a new zsh window in Windows Terminal and run the `3-zsh-sync.sh` by typing: `3`, `tab` and then `enter`.

## What these scripts do

The end goal is to have ZSH as my primary shell running in Windows Terminal through msys2. All applications will be installed through pacman and leveraged through zsh. Development tools, like Nodejs, Docker, Python.

### In a nut shell & in order, these scripts:

1. Configure PowerShell
2. Configure Windows Explorer
3. Download applications through a series of package managers, such as `scoop`, `nuget`, `pacman`, `npm`.
4. Configure each shell. PowerShell, Bash, ZSH.
5. Set up my file system (Pulled from GitHub) and configured through the config.yml file.


## Updating these scripts

The goal is to be able to modify and update these scripts through the `config.yml` file. Things like:

- Which applications are downloaded
- Which Files are downloaded
- Controling the changelog and version number

## Automatic checks

The main PowerShell script is set to perform a numnber of preliminary checks such as:

### Does the user have admin?

if so abort and suggest using Windows Linux Subsystem instead of this script

### Is there a relevent USB Plugged in?

If so then: 
- Download all applications and files to the USB in the `OS` applications area.
- Set up a `WPL` directory in devices

## Script Flags

The PowerShell script (By Far the largest and most comprehensiuve) has 3 possible flags that will prevent the rest of the script from running:

- **`--help`** - Displays a help page
- **`--version`** - Displays the script version number
- **`--changelog`** - Displays the changelog for the whole sync script project.
- **`--todo`** - Shows the todo list of upcoming and completed items (in Markdown).


----

**🤍 2024 [Brenton Holiday](https://brenton.holiday)**
