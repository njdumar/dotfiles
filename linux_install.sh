#!/bin/bash

set -e

if [[ $(id -u) -eq 0 ]] ; then
    echo "Do not run this script as root"
    exit 1
fi

read -p "Enter your email address: " email

configure=false
install=false
clones=false

while true; do
    read -p "Do you wish to install all programs? [y/n]" yn
    case $yn in
        [Yy]* ) install=true; break;;
        [Nn]* ) install=false; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to configure the system (link dotfiles, etc.)? [y/n]" yn
    case $yn in
        [Yy]* ) configure=true; break;;
        [Nn]* ) configure=false; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

cloneDir=`pwd`

#------------------
# Generate SSH keys
#------------------
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Generate ssh keys to upload to git servers"
    echo
    ssh-keygen -t rsa -C $email
fi

#---------------------------
# Package installation
#---------------------------
if $install; then
    echo "Installing all packages for the system"
    echo

    # Update
    sudo pacman -Syu --noconfirm

    # Essentials
    sudo pacman -S --noconfirm --needed base-devel gvim neovim libusb libusb-compat git tig yay tmux terminator alacritty keychain

    # Utilities
    yay -S --noconfirm --needed pavucontrol pasystray network-manager-applet playerctl dmenu pipewire pipewire-alsa pipewire-docs balena-etcher

    # Media
    yay -S --noconfirm --needed spotify steam

    # Fonts
    yay -S --noconfirm --needed ttf-dejavu ttf-iosevka

    # Programming
    yay -S --noconfirm --needed go python python36 python-pip clang gdb ccls ctags cscope perl nodejs yarn fzf ruby perl

    # Random tools
    yay -S --noconfirm --needed firefox chromium shutter gimp slack-desktop tree alacritty-themes libreoffice-fresh repetier-host

    # Trash tools
    yay -S --noconfirm --needed teams tcl

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

if ! $configure; then
    exit 1
fi

#-----------------------------
# Link to dotfiles and configs
#-----------------------------
echo
echo "Create symlinks for dotfiles"

# Create symlinks for all dotfiles
dotfiles=$(find . -maxdepth 1 -name ".*" -type f -printf '%P\n')
configs=$(find .config/ -type f)

# Deal with .vim/ seperately as the only folder to symlink
if [ -d ${cloneDir}/.vim ] && [ ! -L ~/.vim ]; then
    rm -rf ~/.vim
    ln -s ${cloneDir}/.vim ~/.vim
fi

pushd ~

for file in $dotfiles; do

    # skip this clone's specific dotfiles
    if [ $file == ".gitignore" ] || [ $file == ".gitmodules" ]; then
        continue
    fi

    if [ ! -L $file ] && [ ! -f $file ]; then
        ln -s ${cloneDir}/${file} ${file}
    fi
done

echo
echo "Create symlink for .vim/"

echo
echo "Create symlinks for configs"

# Create symlinks for all config files
for file in $configs; do

    dir=$(dirname "$file")

    if [ ! -d $dir ]; then
        mkdir $dir
    fi

    if [ ! -L $file ] && [ ! -f $file ]; then
        ln -s ${cloneDir}/${file} ${file}
    fi
done

popd

# Get themes for alacritty
if [ ! -d ~/.config/alacritty ]; then
    mkdir ~/.config/alacritty
fi
if [ ! -d ~/.config/alacritty/tempus-themes ]; then
    git clone https://gitlab.com/protesilaos/tempus-themes-alacritty.git ~/.config/alacritty/tempus-themes
fi

#---------------------------
# Set up tmux
#---------------------------
pushd ~
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
./.tmux/plugins/tpm/scripts/install_plugins.sh
popd

#--------------------------------------------
# .bashrc
#--------------------------------------------
echo
echo "Update .bashrc"

if ! grep --quiet "bash_aliases" ~/.bashrc; then
    echo "source ~/.bash_aliases" >> ~/.bashrc
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

#---------------------------
# Install all vim bundles
#---------------------------
echo
echo 'Installing Plugs for vim.'
vim -c ":PlugInstall" -c ":qa"
echo

#---------------------------
# ssh server setup
#---------------------------
echo
echo "******* Setup SSH for remote connections and X11 forwarding? [yn]"

sudo sh -c 'echo "AllowTcpForwarding yes
X11UseLocalHost yes
X11DisplayOffset 10 " >> /etc/ssh/sshd_config'

# Restart sshd
sudo systemctl restart sshd
echo

source ~/.bashrc
