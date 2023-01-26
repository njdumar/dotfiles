#!/bin/bash

# NOTE: The playbooks were meant to be run locally on localhost. Updates will be needed
# if it is deployed

sudo pacman -S --noconfirm --needed ansible
ansible-galaxy collection install kewlfft.aur

ansible-playbook -u $USER -K install-arch.yml
ansible-playbook -u $USER -K link-dotfiles.yml
ansible-playbook -u $USER -K configure.yml
