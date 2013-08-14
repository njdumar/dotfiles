#!/usr/bin/python

import re, sys, getopt
import os
import subprocess

# Take a list of svn repository directories:
# svn list --depth infinity <full url> | grep -v '/library/\|/extern/\|/tools/\|/design/\|rel_branches\|trunk/\|tags/\|repo_lock\|\.' > list.txt
# and parse them. Find the root folder containing actual
# branches (not folders containing folders that have branches) and create a .git/config compatible output.
# This will let me choose exactly which branches I want in my git svn clone, instead of waiting for everything

def main(argv):

    svnBranchList = ''
    outputfile = ''
    svn = list()
    url = ''
    ignore = ''
    generate = False
    inputList = ''
    cheat = ''

    try:
        opts, args = getopt.getopt(argv,"hgb:o:s:u:i:c:",["help","generate","branches=","ofile=","svn=","url=","ignore="])
    except getopt.GetoptError:
        print 'parse_svnBranches.py -b <svnBranchList> -o <outputfile>  -s <svn name> -u <url> -i <grep ignore string> -g'
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print '\nExample:'
            print 'parse_svnBranches.py -b <svnBranchList> -o <outputfile>  -s <svn name> -u <url> -i <grep ignore string> -g'
            print '---------------------------------------------------------------------------'
            print '--branches    -b -> file that contains a list of svn branches from the \'svn list\' command'
            print '--ofile    -o -> .gitconfig output file'
            print '--svn      -s -> Name of the svn module (repo)'
            print '--url      -u -> url of the svn repo (minus the repo name/module)'
            print '--generate -g -> If specified, create the input file first'
            exit(0)
        elif opt in ("-b", "--branches"):
            svnBranchList = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg
        elif opt in ("-s", "--svn"):
            svn.append(arg)
        elif opt in ("-u", "--url"):
            url = arg
        elif opt in ("-i", "--ignore"):
            ignore = arg
        elif opt in ("-g", "--generate"):
            generate = True
        elif opt in ("-c"):
            cheat = arg

    if svnBranchList != '':
        svnBranches = open(svnBranchList, 'w')
    else:
        print "Give me the name of the svn branch list! It can be generated so the file doesn't have to exist (use the generate option)"
        exit(2)

    # create the output
    out = open(outputfile, 'w')

    # Create the begining of the config file
    out.write("[core]\n")
    out.write("    repositoryformatversion = 0\n")
    out.write("    filemode = false\n")
    out.write("    bare = false\n")
    out.write("    logallrefupdates = true\n")
    out.write("    symlinks = false\n")
    out.write("    ignorecase = true\n")
    out.write("    autocrlf = false\n")

    for svnRepo in svn:

        if generate:

            svnList = "svn list --depth infinity " + url + "/" + svnRepo + " | grep -v '" + ignore + "'"
            inputList = subprocess.check_output(svnList, shell=True)

            inputList = inputList.split('\n');
        else:
            cheats = open(cheat, 'r')
            inputList = cheats.readlines()
            cheats.close()

        extra = list()
        branchDir = list()
        branchNames = list()
        base = ''
        entry = ''
        first = True

        # Search for every real branch, not folders containing branches, and not folders in branches. Just the branches.
        for index, line in enumerate(inputList):
            copy = False

            # Get the directory of the branch, group(1), and the branch name, group(2)
            branch = re.search(r'(.*/)(.*)/$', line)

            # If the script generates the branch list, there are no newline characters at the end to strip out
            if generate:
                regex = r".*" + line + r".*/.*"
            else:
                regex = r".*" + line[:-1] + r".*/.*"

            if index < len(inputList) - 1:

                if re.search(regex, inputList[index+1]):

                    # This dir contatins branches, it is not a branch itself. This is saved just so I can look at it if I wanted too
                    extra.append(line)

                elif base != branch.group(1):

                    if first == False:

                        # Either create a new list of branch names, or add to a list that already exists, but was out of order (there were
                        # more branches found in that directory later on in the branch list, which is NOT sorted)
                        if base in branchDir:
                            branchNames[branchDir.index(base)] += ("," + entry)
                        else:
                            branchDir.append(base)
                            branchNames.append(entry)

                    base = branch.group(1)
                    entry = branch.group(2)

                    first = False

                    # Save the name of the branch
                    svnBranches.write(svnRepo + "/" + branch.group(1) + branch.group(2) + "\n")

                else:
                    entry = entry + "," + branch.group(2)

                    # Save the name of the branch
                    svnBranches.write(svnRepo + "/" + branch.group(1) + branch.group(2) + "\n")

        # Add the last entry (should be the last branch)
        branchDir.append(base)
        branchNames.append(entry)

        out.write("[svn-remote \"" + svnRepo + "\"]\n")
        out.write("    url = " + url +"/" + svnRepo + "\n")
        out.write("    fetch = trunk:refs/remotes/" + svnRepo + "/trunk\n")
        out.write("    tags = tags/*:refs/remotes/" + svnRepo + "/tags/*\n")
        out.write("    branches = rel_branches/*:refs/remotes/" + svnRepo + "/rel_branches/*\n")

        for index, line in enumerate(branchDir):
            out.write("    branches = " + line + "{" + branchNames[index] + "}:refs/remotes/" + svnRepo + "/" + line + "*\n")

    if svnBranchList != '':
        svnBranches.close

    out.close

if __name__ == "__main__":
    main(sys.argv[1:])

