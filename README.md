# Purpose
This is a collection of configuration files, scripts, and vim plugins that I got tired of copying from machine to machine.
These are meant to be symlinked to the home directory.

# Video Drivers

## Arch

Nvidia drivers can be installed automatically using `nvidia-inst` (install: `yay -Syu nvidia-inst` first).
If a GPU is too old, `nouveau` may need to be used instead, or a manual installation if a legacy driver. For
example: `yay -S nvidia-470xx-dkms`.

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
