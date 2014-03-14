#!/usr/bin/bash

# Generate a new .git/config file, save the svn_branch list for pruning

usage="\n$(basename "$0") [-c <workingdir>] [-u <svnURL>] [-r <rewerite>] [-i reverse grep arg] [-m <module list]

This tool is used to create a git clone of an svn repository. You can clone from an actuall
svn repo or from a local svn sync. Bbtw, everything is faster if you clone from a local sync of
the svn repo you are cloning.

where:
    -h  show this help text
    -c  Required: Full path to the git clone directory. Can be an existing clone or an empty clone
    -u  Required: URL of the base svn repo, do NOT include the module name
    -m  Required: A comma seperated list of svn modules in the svn repository. Each svn module will
        become an svn-remote in the git clone NO SPACES
    -r  Add the rewriteRoot option to the git config.
    -i  An inverted grep of dirs to ignore during the svn list. This is how branches are discovered.
        All directories in the source code should be ignored so that the svn list only shows the paths
        to the branches, not what is in the branches themselves eg. /trunk/\|/tags/\|/src/\|/tools/\|/debug/
    -d  Default options when I am too lazy to type it all out

Example: ./generate_configs.sh -c /home/user/clone/code_clone -u file:///home/user/svn/code_mirror -r http://svn.server/code -m proj1,proj2"

if [ "$1" == "--help" ]; then
    echo "$usage" >&2
  exit 0
fi

if [ -z "$1" ]
  then
    echo "No arguments supplied"
    echo "$usage" >&2
fi

svnURL=""
rewriteRoot=''
cloneDir=''
ignoreList=''
moduleList=''

echo ""

while getopts ':hu:r:c:m:d' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    u) svnURL=$OPTARG
       echo "svnURL = $svnURL"
       ;;
    r) rewriteRoot=$OPTARG
       echo "rewriteRoot = $rewriteRoot"
       ;;
    c) cloneDir=$OPTARG
       echo "Clone dir =  $cloneDir"
       ;;
    i) ignoreList=$OPTARG
       echo "ignore List =  $ignoreList"
       ;;
    m) moduleList=$OPTARG
       echo "module list =  $moduleList"
       ;;
    d) svnURL=file:///home/something
       rewriteRoot=http://svn.server/something
       cloneDir=/home/user/clones/something
       moduleList=proj1,proj2,proj3
       echo "svnURL = $svnURL"
       echo "rewriteRoot = $rewriteRoot"
       echo "Clone dir =  $cloneDir"
       echo "svn modules =  $moduleList"
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ -z "$svnURL" ]
then
    echo "Please supply a url to clone from"
    exit 1
fi

if [ -z "$cloneDir" ]
then
    echo "Please supply the full path to the clone"
    exit 1
fi

if [ -z "$moduleList" ]
then
    echo "Please supply a comma seperated list of svn modules to clone"
    exit 1
fi

# just use the svn url for the rewrite root if none is supplied
if [ -z "$rewriteRoot" ]
then
    rewriteRoot=$svnURL
fi

# just use the my crafted ignore list if one is not provided
if [ -z "$ignoreList" ]
then
    ignoreList="/trunk/\|/tags\|/src/\|/tools/\|"
fi

# Generate the list of svn modules
IFS=","

moduleListArgs=()

for v in $moduleList
do moduleListArgs+=( -s $v)
done

echo $moduleListArgs
echo ""

echo "Generate a new git config file? parse_svnBranchNames.py"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            echo "Create the new git config file"
            ./parse_svnBranchNames.py -b svn_branch_list -o git_config -u $svnURL ${moduleListArgs[@]} -r $rewriteRoot -g -i $ignoreList
            break;;
        No ) break;;
    esac
done

# Find all the branches that were deleted from svn but git still references
echo "Find git remotes to delete? prune.py"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            ./prune.py -s svn_branch_list -g git_branch_list -d $cloneDir -i '/tags/\|trunk\|branches\|@' -o delete_branch_list
            break;;
        No ) break;;
    esac
done

# move the generated config into the git cloneDir and delete the svn metadata, (.git/svn/.metadata)
echo "replace the old config?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            cp $cloneDir/.git/config old_git_config
            cp git_config $cloneDir/.git/config
            rm -f $cloneDir/.git/svn/.metadata
            break;;
        No ) break;;
    esac
done

# Delete all those branches if the user wants too
echo "Delete these branches?"
cat delete_branch_list
echo "----------"

cwd=$(pwd)

select yn in "Yes" "No"; do
    case $yn in
        Yes )
            for i in `cat delete_branch_list`; do
                cd $cloneDir

                git branch -d -r "$i"
                rm -rf .git/svn/refs/remotes/"$i"

                cd $cwd
            done
            break;;
        No ) break;;
    esac
done

# create log and cleanup all the generated files
echo "Delete generated files and create the log.txt?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            echo "\n-------- svn branch list ---------" > log.txt
            cat svn_branch_list >> log.txt
            echo "\n-------- git branch list ---------" >> log.txt
            cat git_branch_list >> log.txt
            echo "\n-------- New git config file ---------" >> log.txt
            cat git_config >> log.txt
            echo "\n-------- Old git config file ---------" >> log.txt
            cat old_git_config >> log.txt
            echo "\n-------- git branches deleted ---------" >> log.txt
            cat delete_branch_list >> log.txt

            rm svn_branch_list
            rm git_branch_list
            rm git_config
            rm old_git_config
            rm delete_branch_list
            break;;
        No ) break;;
    esac
done

# fetch everything
cwd=$(pwd)
cd $cloneDir

echo "Fetch everything? This will take a long time"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            for v in $moduleList
            do
                git svn fetch $v
            done
            break;;
        No ) exit;;
    esac
done

cd $cwd
