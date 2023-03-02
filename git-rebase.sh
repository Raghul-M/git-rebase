#!/bin/sh

set -e

REPO=$1
SOURCE_BRANCH=$2
DESTINATION_BRANCH=$3

if ! echo ${REPO} | grep -Eq ':|@|\.git\/?$'; then
  if [[ -n "${SSH_PRIVATE_KEY}" || -n "${SOURCE_SSH_PRIVATE_KEY}" ]]; then
    REPO="git@github.com:${REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    REPO="https://github.com/${REPO}.git"
  fi
fi

echo "SOURCE=${REPO}:${SOURCE_BRANCH}"
echo "DESTINATION=${REPO}:${DESTINATION_BRANCH}"

git clone "${REPO}" /root/repo --origin remote-repo && cd /root/repo

# Pull all branches references down locally so subsequent commands can see them
git fetch remote-repo '+refs/heads/*:refs/heads/*' --update-head-ok

# Print out all branches
git --no-pager branch -a -vv

git config --local user.name "$(git log -n 1 --pretty=format:%cn ${SOURCE_BRANCH})"
git config --local user.email "$(git log -n 1 --pretty=format:%ce ${SOURCE_BRANCH})"

git rebase --onto "${DESTINATION_BRANCH}" "${DESTINATION_BRANCH}" "${SOURCE_BRANCH}"
git push remote-repo HEAD:"${SOURCE_BRANCH}" -f
