if [ -z $ASCIIDOC_UTILS_PATH ]; then
    # Get the path to the current folder
    #
    # This is not 100% portable, but most distributions come with a readlink that does support -f
    # An exception to this is OSX, where you'll have to `brew install coreutils` and use greadlink
    #
    # Additionally, not all shells set BASH_SOURCE. If your shell does not, you'll
    # have to set ASCIIDOC_UTILS_PATH
    ASCIIDOC_UTILS_PATH="$(dirname "$(readlink -f "$BASH_SOURCE[0]")")"
fi

if [ ! -f "$ASCIIDOC_UTILS_PATH/main.sh" ]; then
    echo "Please set ASCIIDOC_UTILS_PATH to the folder containing main.sh" >&2
    exit 1
fi

eval $(find "$ASCIIDOC_UTILS_PATH" -type f -name '*.sh' ! -name 'main.sh' -exec echo . \'{}\'';' \;)

