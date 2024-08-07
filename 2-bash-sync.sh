# Symlink BASH preference files
# Symlink Bash DotFiles to $Home Directory

# link bash rc file - rc.bash .bashrc
ln -s $HOME\Settings\Shells\Bash\rc.bash $HOME\.bashrc

# link bash lougout - logout.bash .bash_logout
ln -s $HOME\Settings\Shells\Bash\logout.bash $HOME\.bash_logout

# LINK BASH POFILE - profile.bash .bash_profile
ln -s $HOME\Settings\Shells\Bash\profile.bash $HOME\.bash_profile


# link general profile - profile.sh .profile
ln -s $HOME\Settings\Shells\Bash\profile.sh $HOME\.profile

# All Powershell and Windows apps

echo "Configuring bash"

pacman -Fy msys

pacman -S zsh fish openssh git wget curl --noconfirm

