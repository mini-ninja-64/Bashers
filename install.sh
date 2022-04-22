#!/bin/sh

set -e

fullPath() {
  echo $(realpath "$1")
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
  *zsh)  RC_FILE="$HOME/.zshrc" ;;
  *bash) RC_FILE="$HOME/.bashrc" ;;
  *sh)   RC_FILE="$HOME/.profile" ;;
  *)     echo "unsupported shell" && exit 1 ;;
esac

printf "\nBased on the running shell, this will update '$RC_FILE'\n"

printf "\nAttempting to clone 'Bashers' inside of '$CLONE_DIRECTORY'\n"
mkdir -p "$CLONE_DIRECTORY"
git -C "$CLONE_DIRECTORY" clone git@github.com:mini-ninja-64/Bashers.git

RC_ADDITION="
BASHERS_DIR="$CLONE_DIRECTORY/Bashers"
source \"\$BASHERS_DIR/.bashersrc\"
"

printf "\nAdding the following to '%s':\n%s" "$RC_FILE" "$RC_ADDITION"

echo "$RC_ADDITION" >> "$RC_FILE"
printf "\nInstall completed!\nrun 'source %s' or restart your terminal\n" "$RC_FILE"