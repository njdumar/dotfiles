# Purpose
This is a collection of configuration files, scripts, and vim plugins that I got tired of copying from machine to machine.

# Installation (Arch linux):
Install all packages, link all dotfiles/.configs, and other misc setup
```
./setup_arch.sh
```

# Terminal color test:
To check if your terminal and/or tmux session supports 256 colors:
```
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
```
The resulting output should have a smooth color gradient
