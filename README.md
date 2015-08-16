dotfiles
==========

This is a collection of configuration files, scripts, and vim plugins that I got tired of copying from machine to machine.

Prerequisites
------------
- Get vim 7.3.584 or later that has been compiled with python support for YCM to work correctly
    (may need to compile vim yourself https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)
- Install Excuberant-tags and Cscope

Installation (linux):
-------------

1. git clone http://github.com/CaptainOfCrush/dotfiles.git dotfiles

2. cd dotfiles; git submodule update --init

3. Create sym link in home dir (~/) pointed to dotfiles/ for .vimrc, .gitconfig, .bash_aliases, and .vim/
    - NOTE: If you don't want to use my .vimrc, you at least need the vundle specific stuff that's in 
      there to get all the plugins. Just serach for vundle or Bundle in this vimrc and you'll find it.

4. Get all the vundle plugins 
    - Open vim, :BundleInstall

6. Add .bash_aliases to your regular .bashrc/.bash_profile/whatever to source it

Remember:
---------

1. All scripts should work correctly, don't forget to install python,ruby,perl,...etc. 
   However, .gitconfig expects the clone to be located in ~/dotfiles/

2. For the plugins to work correctly, vim needs python support. You most likely
   need to compile vim from source to get a recent enough version. See YCM 
   documentation for more info

3. Vim plugin list includes:
    - NerdTree
    - TagList
    - TagBar
    - matchTag
    - syntastic
    - OmniCppComplete
    - undotree
    - bufexplorer
    - Xterm-color-table
    - Vundle (vim plugin manager)
    - YouCompleteMe
    - and others


4. For the guide to installing YCM:
   https://github.com/Valloric/YouCompleteMe
