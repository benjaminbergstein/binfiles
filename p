#!/bin/bash

BROWN='\033[0;33m'
NC='\033[0m' # No Color

color () {
  printf "${BROWN}${1}${NC}"
}

git add -p

git log -1
color "Edit? "
read -r edit

if [ "$edit" = "y" ]
then
  git commit
else
  git cane
fi

if [ "$(current-branch)" = "master" ]
then
  color "Will not push to master.\n"
  exit 1
fi

echo ""
color "*Enter* to push to <$(current-branch)> ...\n"
read -r line

git pf
