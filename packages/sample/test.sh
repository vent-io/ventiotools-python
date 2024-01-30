#!/bin/env bash

# WHEN EDITING THIS FILE, USE SHELLCHECK: https://www.shellcheck.net/
# SHELL/BASH IS WAY TOO ARCANE TO BE AWARE OF ALL THE GOTCHAS.
# Also available for VSCode: https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck

# You really want these, they eliminate a lot of footguns around bash scripts.
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment to see each command as it executes

cd "$(dirname "$0")"  # Switch to this file's directory so relative paths work

test_directly() {
    # Use `export` for sub-processes to see these variables. Use single quotes to force
    # literal interpretation, with no interpolation etc.
    export NODE_OPTIONS='--trace-warnings'
    npm install && npx jest
}

test_via_docker(){
    IMAGE_NAME="test"
    MULTI_STAGE_BUILD_STAGE_NAME="test"

    # ALWAYS use double quotes, unless you want to disable interpolation. Double quotes
    # don't hurt, and no quotes are asking for trouble.
    docker buildx build --target "$MULTI_STAGE_BUILD_STAGE_NAME" --tag "$IMAGE_NAME" .
    docker run --env NODE_OPTIONS="$NODE_OPTIONS" "$IMAGE_NAME"
}

# You can do whatever you want in here, you can for example...
test_directly # which is fast and native, but more brittle,
#
# OR (doesn't make sense to use both!)
#
test_via_docker # which is slower, but *much* more reliable, portable and supported.
