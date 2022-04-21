#!/bin/sh

set -e

fullPath() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

RELATIVE_CLONE_DIRECTORY="$1"
if [ -z "$RELATIVE_CLONE_DIRECTORY" ]; then
    echo "Please specify a directory to clone Bashers too as the first argument of this script"
    exit 1
fi

CLONE_DIRECTORY=$(fullPath "$RELATIVE_CLONE_DIRECTORY")

echo "Installing bashers (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧"

RC_FILE=""
case "$SHELL" in
  *zsh)  RC_FILE="~/.zshrc" ;;
  *bash) RC_FILE="~/.bashrc" ;;
  *sh)   RC_FILE="~/.profile" ;;
  *)     echo "unsupported shell" && exit 1 ;;
esac

printf "\nBased on the running shell, this will update '$RC_FILE'\n"

printf "\nAttempting to clone 'Bashers' inside of '$CLONE_DIRECTORY'\n"
mkdir -p "$CLONE_DIRECTORY"
git -C "$CLONE_DIRECTORY" clone git@github.com:mini-ninja-64/Bashers.git

printf "\nAdding the following to '$RC_FILE':\n"
RC_ADDITION="
BASHERS_DIR="$CLONE_DIRECTORY/Bashers"
export PATH=\"\$PATH:\$BASHERS_DIR/bash\"
"
echo "$RC_ADDITION"

echo "$RC_ADDITION" >> "$RC_FILE"
