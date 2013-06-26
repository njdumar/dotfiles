#!/bin/bash
# Arguments:
#   1 -> project name (directories under ~/Projects)

if [ $1 = "-h"  ]
then
    echo "Argument 1: Project directory"
    exit
fi

echo $1 $2 $3 $4 $#

args=("$@")

COUNT=1

for var in "$@"; do

    # process arguments
        cd $var

        rm $var/tags
        rm $var/cscope.out
        rm $var/ncscope.out
        rm $var/cscope.files

        find . -iname '*.dat' -o -iname '*.tcl' -o -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' \
              -o -iname '*.hh' -o -iname '*.hpp' -o -iname '*.inc' -o -iname '*.asm' -o -iname '*.ipp' \
              -o -iname '*.s'  -o -iname '*.spp'> cscope.files

        ctags -f `pwd`/tags -a\
            -h \".php.inc\" -L cscope.files -I \
            --exclude=\"\.svn\" \
            --exclude=\"examples\" \
            --totals=yes \
            --tag-relative=yes \
            --PHP-kinds=+cf \
            --python-kinds=+i \
            --c++-kinds=+p \
            --extra=+q  \
            --fields=+liaS \
            --language-force=C++ \

        cscope -b -i cscope.files -f cscope.out

    let COUNT=COUNT+1
done
