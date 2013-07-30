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

    inputfile = ''
    outputfile = ''
    svn = list()
    url = ''
    generate = False

    try:
        opts, args = getopt.getopt(argv,"hi:o:s:u:g",["ifile=","ofile=","svn=","url=","generate="])
    except getopt.GetoptError:
        print 'test.py -i <inputfile> -o <outputfile> -s <svn name>'
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print 'parse_svnBranches.py -i <inputfile> -o <outputfile>  -s <svn name> -u <url>'
            print '---------------------------------------------------------------------------'
            print '--ifile    -i -> file that contains a list of svn branches from the \'svn list\' command'
            print '--ofile    -o -> .gitconfig output file'
            print '--svn      -s -> Name of the svn module (repo)'
            print '--url      -u -> url of the svn repo (minus the repo name/module)'
            print '--generate -g -> If specified, create the input file first'
            exit(0)
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg
        elif opt in ("-s", "--svn"):
            svn.append(arg)
        elif opt in ("-u", "--url"):
            url = arg
        elif opt in ("-g", "--generate"):
            generate = arg

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

    for svnRepo in svn:

        if generate:

            svnList = "svn list --depth infinity " + url + "/" + svnRepo + " | grep -v '/library/\|/extern/\|/tools/\|/design/\|rel_branches\|trunk/\|tags/\|repo_lock\|(\|)\|\.'"
            output = subprocess.check_output(svnList, shell=True)

            # The reason this is even put into a file in the first place is so that I can analyze the results before the git config is created
            # There were some issues getting the 'svn list' just right
            f = open(inputfile, 'w')
            f.write(output)
            f.close

        f = open(inputfile)
        inputFile = f.readlines()
        f.close

        extra = list()
        branchDir = list()
        branchNames = list()
        base = ''
        entry = ''
        first = True

        # Search for every real branch, not folders containing branches, and not folders in branches. Just the branches.
        for index, line in enumerate(inputFile):
            copy = False 

            # Get the directory of the branch, group(1) and the branch name, group(2)
            branch = re.search(r'(.*/)(.*)/$', line)

            regex = r".*" + line[:-1] + r".*/.*"

            if index < len(inputFile) - 1:

                if re.search(regex, inputFile[index+1]):

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

                else:
                    entry = entry + "," + branch.group(2)

        # Add the last entry (should be the last branch)
        branchDir.append(base)
        branchNames.append(entry)

        out.write("[svn-remote \"svn\"]\n")
        out.write("    url = " + url +"/" + svnRepo + "\n")
        out.write("    fetch = trunk:refs/remotes/" + svnRepo + "/trunk\n")
        out.write("    tags = tags/*:refs/remotes/" + svnRepo + "/tags/*\n")
        out.write("    branches = rel_branches/*:refs/remotes/" + svnRepo + "/rel_branches/*\n")

        for index, line in enumerate(branchDir):
            out.write("    branches = " + line + "{" + branchNames[index] + "}:refs/remotes/" + svnRepo + "/" + line + "*\n")

        out.close

if __name__ == "__main__":
    main(sys.argv[1:])

