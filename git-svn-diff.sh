#!/bin/bash
#
# git-svn-diff originally by (http://mojodna.net/2009/02/24/my-work-git-workflow.html)
# modified by mike@mikepearce.net
# modified by aconway@[redacted] - handle diffs that introduce new files
#
# Generate an SVN-compatible diff against the tip of the tracking branch
 
# Get the tracking branch (if we're on a branch)
#TRACKING_BRANCH=`git svn info | grep URL | sed -e 's/.*\/branches\///'`
 
# If the tracking branch has 'URL' at the beginning, then the sed wasn't successful and
# we'll fall back to the svn-remote config option
#if [[ "$TRACKING_BRANCH" =~ URL.* ]]
#then
#TRACKING_BRANCH=`git config --get svn-remote.svn.fetch | sed -e 's/.*:refs\/remotes\///'`
#fi
 
# Get the highest revision number
REV=`git svn info | grep 'Last Changed Rev:' | sed -E 's/^.*: ([[:digit:]]*)/\1/'`
 
# Then do the diff from the highest revision on the current branch
# and masssage into SVN format
#git diff --no-prefix $(git rev-list --date-order --max-count=1 $TRACKING_BRANCH) $* |
git diff --no-prefix $* |

# This is the original, probably good for linux
sed -e "/--- \/dev\/null/{ N; s|^--- /dev/null\n+++ \(.*\)|---\1 (revision 0)\n+++\1 (revision 0)|;}" \
-e "s/^--- .*/&\t(revision $REV)/" \
-e "s/^+++ .*/&\t(working copy)/" \
-e "s/^diff --git [^[:space:]]*/Index:/" \
-e "s/^index.*/===================================================================/"

# This works for Windows
#sed -e "s/^--- .*/& (revision $REV)/" \
#    -e "s/^+++ .*/& (working copy)/" \
#    -e "s/^diff --git [^[:space:]]*/Index:/" \
#    -e "s/^index.*/===================================================================/" \
#    -e "/^--- \/dev\/null (revision $REV)$/{N;s/--- \/dev\/null (revision $REV)\n+++ \(.*\) (working copy)/--- \1 (revision 0)\n+++ \1 (working copy)/}" \
#    -e "/^--- .* (revision $REV)$/{N;s/--- \(.*\) (revision $REV)\n+++ \/dev\/null (working copy)/--- \1 (revision $REV)\n+++ \1 (working copy)/}"
