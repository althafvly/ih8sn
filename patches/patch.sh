#!/bin/bash

PATCH_DIR=${PWD}
echo "TOP: $PATCH_DIR"

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
GREEN='\033[0;32m'
LIGHTBLUE='\033[1;34m'

#################################################################
# Apply patches
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################
apply_patch() {
    echo -e "${GREEN}Downloading patch $2...${NOCOLOR}"
    cd "$PATCH_DIR" || exit
    wget -O "$2" https://raw.githubusercontent.com/althafvly/ih8sn/master/patches/"$2" -q --show-progress
    echo -e "${GREEN}.................${NOCOLOR}"
    echo -e "${GREEN}Applying patch...${NOCOLOR}"
    echo -e "${LIGHTBLUE}Target repo:${NOCOLOR} $1"
    echo -e "${LIGHTBLUE}Patch file:${NOCOLOR} $2"

    if [ -d "$1" ] && [ -f "$PATCH_DIR/$2" ]; then
        cd "$1" || exit
        git am -3 --ignore-whitespace "$PATCH_DIR/$2"
        cd "$PATCH_DIR" && echo ""
    else
        echo "Can't find dir $1 or patch file $2, skipping patch"
    fi

    if [ -f "$PATCH_DIR/$2" ]; then
        rm "$PATCH_DIR/$2"
    fi
    echo -e "${GREEN}.................${NOCOLOR}"
}

apply_patch frameworks/base 0001-base-Block-key-attestation-for-SafetyNet.patch

