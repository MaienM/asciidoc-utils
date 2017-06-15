#!/bin/sh

# Get the path to the folder containing this script
# This is not 100% portable, but most distributions come with a readlink that does support -f
# An exception to this is OSX, where you'll have to `brew install coreutils` and use greadlink
cf="$(dirname "$(readlink -f "$0")")"

# Concatenate all the source files
echo "Building to asciidoc-utils.sh"
find "$cf/../src" -type f -name '*.sh' -exec cat '{}' \; > asciidoc-utils.sh
