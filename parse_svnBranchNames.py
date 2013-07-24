#!/usr/bin/python

import re, sys, getopt
import os
from subprocess import call

# Take a list of svn repository directories:
# svn list --depth infinity <full url> | grep -v '/library/\|/extern/\|/tools/\|/design/\|rel_branches\|trunk/\|tags/\|repo_lock\|\.' > smr6_list.txt
# and parse them. Find the root folder containing actual
# branches (not folders containing folders that have branches) and create a gitconfig compatible output.
# This will let me choose exactly which branches I want in my git svn clone, instead of waiting for everything

# Obviously, create the list.txt from the command above. I really should have python do it, but that command
# will take a very long time to run on a complex repo (lots of directories/branches)

def main(argv):

    inputfile = ''
    outputfile = ''
    svn = list()
    url = ''
    generate = False

    try:
        opts, args = getopt.getopt(argv,"hi:o:s:u:g:",["ifile=","ofile=","svn=","url=","generate="])
    except getopt.GetoptError:
        print 'test.py -i <inputfile> -o <outputfile> -s <svn name>'
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print 'test.py -i <inputfile> -o <outputfile>  -s <svn name>'
            sys.exit()
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

    #print 'Input file is "', inputfile
    #print 'Output file is "', outputfile
    #call(["svn", "list", "--depth", "infinity", ])
    if generate:

        for svnRepo in svn:

            os.system("svn list --depth infinity " + url + "/" + svnRepo + " | grep -v '/library/\|/extern/\|/tools/\|/design/\|rel_branches\|trunk/\|tags/\|repo_lock\|\.' > " + inputfile)
            print "svn list --depth infinity " + url + "/" + svnRepo + " | grep -v '/library/\|/extern/\|/tools/\|/design/\|rel_branches\|trunk/\|tags/\|repo_lock\|\.' > " + inputfile

        exit(0)

    f = open(inputfile)
    inputFile = f.readlines()
    f.close

    extra = list()
    branchDir = list()
    branchNames = list()
    base = ''
    entry = ''
    first = True

    for index, line in enumerate(inputFile):
        copy = False 
        branch = re.search(r'(.*/)(.*)/$', line)

        regex = r".*" + line[:-1] + r".*/.*"

        if index < len(inputFile) - 1:

            if re.search(regex, inputFile[index+1]):

                # This dir contatins branches, it is not a branch itself
                extra.append(line)

            elif base != branch.group(1):

                if first == False:
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

    # Add the last entry
    branchDir.append(base)
    branchNames.append(entry)

    for svnRepo in svn:
        print "[core]"
        print "    repositoryformatversion = 0"
        print "    filemode = false "
        print "    bare = false "
        print "    logallrefupdates = true"
        print "    symlinks = false"
        print "    ignorecase = true"
        print "[svn-remote \"svn\"]"
        print "    url = " + url +"/" + svnRepo
        print "    fetch = trunk:refs/remotes/" + svnRepo + "/trunk"
        print "    tags = tags/*:refs/remotes/" + svnRepo + "/tags/*"
        print "    branches = rel_branches/*:refs/remotes/" + svnRepo + "/rel_branches/*"

    for index, line in enumerate(branchDir):
        print "#    branches = " + line + "{" + branchNames[index] + "}:refs/remotes/" + svn + "/" + line + "*"

if __name__ == "__main__":
    main(sys.argv[1:])

