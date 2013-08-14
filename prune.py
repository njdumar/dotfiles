#!/usr/bin/python

import re, sys, getopt
import os
import subprocess


def main(argv):

    svnBranches = ''
    gitBranches = ''
    output = ''
    directory = ''
    ignoreList = '/tags/'
    dryRun = False

    try:
        opts, args = getopt.getopt(argv,"hs:g:o:d:i:", ["dry-run", "help"])
    except getopt.GetoptError:
        print "./prune.py -s <svn list> -g <git list> -d <git directory> -o <output>"
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h","--help"):
            print '\nExample:'
            print "./prune.py -s <svn list> -g <git list>"
            print '---------------------------------------------------------------------------'
            print '-h -> help'
            print '-s -> list of svn branches'
            print '-g -> list of git branches'
            print '-d -> directory containing the git repo you are pruning'
            print '-o -> outoput file containing all the branches being deleted, good for a reference. Optional'
            print '-i -> Inverse grep of what to ignore. default: \'/tags/\''
            exit(0)
        elif opt in ("-s"):
            svnBranches = arg
        elif opt in ("-g"):
            gitBranches = arg
        elif opt in ("-o"):
            output = arg
        elif opt in ("-d"):
            directory = arg
        elif opt in ("-i"):
            ignoreList = arg
        elif opt in ("--dry-run"):
            dryRun = True

    # This file is created by the parse_svnBranchNames.py script
    svn = open(svnBranches, 'r')
    svnList = svn.readlines()
    svn.close

    # Generate the git branch list, ignoring  at least tags, Remove the preceeding spaces
    pwd = os.getcwd()
    cmd = "git branch -r | sed 's|^[[:space:]]*||' | grep -v '" + ignoreList + "' > " + pwd + "/" + gitBranches
    results = subprocess.check_output(cmd, shell=True, cwd=directory)

    git = open(gitBranches, 'r')
    gitList = git.readlines()
    git.close

    diff = list(set(gitList) - set(svnList))
    diff = ''.join(diff)

    # Save the list of branches to be deleted, either put it in a file or just print it to the screen
    if output != '':

        out = open(output, 'w')
        out.write(diff)
        out.close
    else:

        print diff

    if not dryRun:

        cmd = "ls"
        results = subprocess.check_output(cmd, shell=True, cwd=directory)

if __name__ == "__main__":
    main(sys.argv[1:])

