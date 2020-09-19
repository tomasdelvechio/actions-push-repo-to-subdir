#!/bin/bash

#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"

set -e

#FOLDER=$1
#STARTER_NAME="${2:-name}"
GITHUB_USERNAME=$1
TARGET_REPOSITORY_PATH=$2
DIRNAME="$(basename $(dirname $TARGET_REPOSITORY_PATH))"
LOWER_DIRNAME="$(echo $DIRNAME | tr '[:upper:]' '[:lower:]')"
SUBDIR_NAME="${3:-$LOWER_DIRNAME}"
REPO_SOURCE_PATH=$(pwd)

git config --global user.email "tomasdelvechio-actions-syn-repos@example.org"
git config --global user.name "$GITHUB_USERNAME"

#cd $BASE
CLONE_DIR=/tmp/$TARGET_REPOSITORY_PATH
mkdir -p $CLONE_DIR
git clone --depth 1 https://$API_TOKEN_GITHUB@github.com/$TARGET_REPOSITORY_PATH.git $CLONE_DIR &> /dev/null

echo "Directory: $CLONE_DIR"
cp -TR $REPO_SOURCE_PATH $CLONE_DIR/$SUBDIR_NAME
cd $CLONE_DIR
rm -rf $SUBDIR_NAME/.git $SUBDIR_NAME/.vscode
git status
git add .
git commit -m 'auto sync of repo with tomasdelvechio/actions-push-repo-to-subdir'
git push