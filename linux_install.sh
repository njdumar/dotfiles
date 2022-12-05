#!/bin/bash

#--------------------------------------------------------------------
# Arch linux install script
#    - Install all packages needed for developement
#    - If dotfiles or config are provided, link them all
#    - Set up system for remote developement
#--------------------------------------------------------------------

set -e

#----------------------------------------
# Get all the user prompts out of the way
#----------------------------------------
install=false
linkDotfiles=false

if [[ $(id -u) -eq 0 ]] ; then
    echo "Do not run this script as root"
    exit 1
fi

read -p "Enter your email address: " email

while true; do
    read -p "Do you wish to install all programs? [y/n]" yn
    case $yn in
        [Yy]* ) install=true; break;;
        [Nn]* ) install=false; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to link existing dotfiles that already exist (eg. clone containing all your dotfiles)? [y/n]" yn
    case $yn in
        [Yy]* ) linkDotfiles=true; break;;
        [Nn]* ) linkDotfiles=false; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

dotfilesDir=`pwd`
dotfiles=$(find . -maxdepth 1 -name ".*" -type f -printf '%P\n')
configs=$(find .config/ -type f)

if [ $linkDotfiles ]; then
    if [[ (-z $dotfiles && -z $configs) || $dotfilesDir -ef ~ ]]; then
        echo
        echo "No dotfiles or .config/ files found here: ${dotfilesDir}"
        echo
        echo ""
        echo
        read -p "Please enter the full path to your dotfiles folder eg. /home/user/dotfiles: " dotfilesDir

        if [ ! -d $dotfilesDir]; then
            echo "This directory does not exist : ${dotfilesDir}"
            exit 1
        fi

        pushd $dotfilesDir
        dotfiles=$(find . -maxdepth 1 -name ".*" -type f -printf '%P\n')
        configs=$(find .config/ -type f)
        popd

        if [[ -z $dotfiles && -z $configs ]]; then
            echo "No dotfiles or .config/ files found here: ${dotfilesDir}"
            exit 1
        fi

        if [ $dotfilesDir -ef ~ ]; then
            echo
            echo "This is being run from the home directory, can't symlink files. Try again, but do it better"
            exit 1
        fi
    fi
fi

#--------------------------------------------
# Generate SSH keys
#--------------------------------------------
if [ ! -f ~/.ssh/id_rsa ]; then
    echo
    echo "Generate ssh keys"
    echo
    ssh-keygen -t rsa -C $email
fi

#--------------------------------------------
# Package installation
#--------------------------------------------
if $install; then
    echo "Installing all packages for the system"
    echo

    # Update
    sudo pacman -Syu --noconfirm

    # Essentials
    sudo pacman -S --noconfirm --needed base-devel yay
    yay -S --noconfirm --needed tmux terminator alacritty keychain gvim neovim libusb libusb-compat git tig i3-gaps dmenu

    # Utilities
    yay -S --noconfirm --needed pavucontrol pasystray network-manager-applet playerctl blueman dunst bash-completion
    yay -S --noconfirm --needed pipewire pipewire-alsa pipewire-docs arandr samba rsync easyeffects btop

    # Media
    #yay -S --noconfirm --needed spotify
    yay -S --noconfirm --needed zenity ffmpeg4.4 steam

    # Fonts
    yay -S --noconfirm --needed ttf-dejavu ttf-iosevka

    # Programming
    yay -S --noconfirm --needed go python python36 python-pip clang gdb ccls ctags cscope perl nodejs yarn fzf ruby perl

    # Random tools
    yay -S --noconfirm --needed firefox chromium shutter gimp slack-desktop meld feh balena-etcher vlc openscad
    yay -S --noconfirm --needed tree alacritty-themes libreoffice-fresh remmina repetier-host supertuxkart

    # Install and start docker
    # If the service fails to start up, complaining about a bridge adapter not installed, may need to reboot after a new kernel
    yay -S --noconfirm --needed gnome-terminal docker docker-compose
    sudo systemctl enable --now docker.service

    # Install and start remote desktop, xrdp
    yay -S --noconfirm --needed xrdp
    sudo systemctl enable --now xrdp

    # Install and start ssh server
    yay -S --noconfirm --needed openssh
    sudo systemctl enable --now sshd.service

    # Install virtualbox. May require a restart?
    yay -S --noconfirm --needed virtualbox virtualbox-host-dkms linux-lts-headers
    sudo modprobe vboxdrv
fi

if $linkDotfiles; then

    #--------------------------------------------
    # Link to dotfiles and configs that exist
    #--------------------------------------------
    echo
    echo "Create symlink for .vim/"

    # Deal with .vim/ seperately as the only folder to symlink
    if [ -d ${dotfilesDir}/.vim ] && [ ! -L ~/.vim ]; then
        rm -rf ~/.vim
        ln -s ${dotfilesDir}/.vim ~/.vim
    fi

    echo
    echo "Create symlinks for dotfiles"

    for file in $dotfiles; do

        # skip the clone's specific dotfiles
        if [ $file == ".gitignore" ] || [ $file == ".gitmodules" ]; then
            continue
        fi

        if [ ! -L ~/${file} ] && [ ! -f ~/${file} ]; then
            ln -s ${dotfilesDir}/${file} ~/${file}
        fi
    done

    echo
    echo "Create symlinks for configs"

    # Create symlinks for all config files
    for file in $configs; do

        dir=$(dirname "$file")
        base=$(basename "$file")

        # Make sure the config's folder path exists eg. ~/.config/i3/
        if [ ! -d ~/$dir ]; then
            mkdir ~/$dir
        fi

        if [ ! -L ~/${file} ] && [ ! -f ~/${file} ]; then
            ln -s ${dotfilesDir}/${file} ~/${file}
        fi
    done

    # Get themes for alacritty
    if [ ! -d ~/.config/alacritty ]; then
        mkdir ~/.config/alacritty
    fi
    if [ ! -d ~/.config/alacritty/tempus-themes ]; then
        git clone https://gitlab.com/protesilaos/tempus-themes-alacritty.git ~/.config/alacritty/tempus-themes
    fi

    #--------------------------------------------
    # Install tmux plugin system
    #--------------------------------------------
    pushd ~
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    ./.tmux/plugins/tpm/scripts/install_plugins.sh
    popd

    #--------------------------------------------
    # Install all vim plugins
    #--------------------------------------------
    echo
    echo 'Installing Plugs for vim.'
    vim -c ":PlugInstall" -c ":qa"
    echo
fi

#--------------------------------------------
# .bashrc updates
#--------------------------------------------
echo
echo "Update .bashrc"

if ! grep --quiet "bash_aliases" ~/.bashrc; then
    echo "if [ -f ~/.bash_aliases ]; then source ~/.bash_aliases; fi" >> ~/.bashrc
    echo "if [ -f ~/.bash_other ]; then source ~/.bash_other; fi" >> ~/.bashrc
fi

#--------------------------------------------
# Git Config Setup
#--------------------------------------------
echo
echo "Git config Setup:"

if [ -z "`git config --global user.name`" ]; then
    echo "Enter your full name:"
    read name
    git config --global user.name "$name"
fi
if [ -z "`git config --global user.email`" ]; then
    echo "Enter your e-mail address: "
    read email
    git config --global user.email "$email"
fi

git config --global pull.rebase true
git config --global branch.autosetuprebase always
git config --global rerere.enabled true
git config --global diff.renameLimit 999999
git config --global merge.renameLimit 999999
git config --global merge.conflictstyle diff3
git config --global merge.ff false
git config --global fetch.prune true
git config --global core.warnambiguousrefs false

#--------------------------------------------
# ssh server setup
#--------------------------------------------
sudo sh -c 'echo "AllowTcpForwarding yes
X11UseLocalHost yes
X11DisplayOffset 10 " >> /etc/ssh/sshd_config'

# Restart sshd
sudo systemctl restart sshd
echo

source ~/.bashrc
