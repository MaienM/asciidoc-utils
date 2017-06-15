# Process multi-line strings from:
#
# unindent "
#   hello world
#   stuff
# "
#
# into:
#
# "hello world
# stuff"
#
# Does NOT expand escape sequences
unindent() {
    /bin/echo "$@" | awk -f "$PROJECT_TESTS_PATH/helpers/unindent.awk"
}

