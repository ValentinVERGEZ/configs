#!/bin/bash

BRANCH=`git rev-parse --abbrev-ref HEAD` && IFS="." && declare -a VALUES=($BRANCH)
if [ ${#VALUES[@]} -gt 1 ]; then
	if [ ${VALUES[${#VALUES[@]}-1]} == "dev" ]; then
	  echo -e "\033[31m==================="
	  echo -e "Switch on MAIN banch"
	  echo -e "====================\033[0m"
	  git checkout @{u}
	fi
else
  echo -e "\033[32m===================="
  echo -e "Switch on DEV banch"
  echo -e "====================\033[0m"
  git checkout ${BRANCH}.dev
fi
