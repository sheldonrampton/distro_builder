#!/bin/bash
# Include configuration.
CONFIG_FILE="config/builder.conf"
if [[ -f $CONFIG_FILE ]]; then
  . $CONFIG_FILE
fi

GITURL="$(git config --get remote.$DISTRO_REMOTE.url)"
echo "Pulling in latest updates on distro $DISTRO_BRANCH_NAME from remote $GITURL."
 
# Change to git root directory.
cd "$(git rev-parse --show-toplevel)"
find . -name ".DS_Store" -depth -exec rm {} \;
git checkout $DISTRO_BRANCH_NAME
git pull --rebase
git checkout $PROJECT_BUILDER_BRANCH
git merge --squash -s subtree --no-commit $DISTRO_BRANCH_NAME
