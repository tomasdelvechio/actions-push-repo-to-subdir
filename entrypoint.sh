#!/bin/bash

set -e

GITHUB_USERNAME=$1
TARGET_SUBDIR_NAME=$2
SOURCE_PATH=$GITHUB_WORKSPACE/source-repo
TARGET_PATH=$GITHUB_WORKSPACE/target-repo

git config --global user.email "tomasdelvechio-actions-syn-repos@example.org"
git config --global user.name "$GITHUB_USERNAME"

cp -TR $SOURCE_PATH $TARGET_PATH/$TARGET_SUBDIR_NAME
cd $TARGET_PATH
rm -rf $TARGET_SUBDIR_NAME/.git $TARGET_SUBDIR_NAME/.gitignore $TARGET_SUBDIR_NAME/.vscode
git add .
git commit -m 'auto sync of repo with tomasdelvechio/actions-push-repo-to-subdir'
git push