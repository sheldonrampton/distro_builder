#!/bin/bash
# Include configuration.
CONFIG_FILE="scripts/builder.conf"
if [[ -f $CONFIG_FILE ]]; then
  . $CONFIG_FILE
fi

GITURL="$(git config --get remote.$PROJECT_INTEGRATION_REMOTE.url)"
echo "Pulling in latest updates on branch $DISTRO_BRANCH from remote $GITURL."
 
# Change to git root directory.
cd "$(git rev-parse --show-toplevel)"
find . -name ".DS_Store" -depth -exec rm {} \;
git checkout distro_builder
git pull --rebase
git checkout master
git merge --squash -s subtree --no-commit distro_builder