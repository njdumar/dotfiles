dotfiles
==========

This is a collection of configuration files, scripts, and vim plugins that I got tired of copying from machine to machine.

Prerequisites
------------
- Install Excuberant-tags and Cscope

Installation (linux):
-------------

1. git clone http://github.com/CaptainOfCrush/dotfiles.git dotfiles

2. cd dotfiles; git submodule update --init

3. Create sym link in home for all dotfiles

4. Get all the vundle plugins
    - Open vim, :BundleInstall

6. Add .bash_aliases to your regular .bashrc/.bash_profile/whatever to source it
