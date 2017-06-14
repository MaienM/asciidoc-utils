# Run a command in the right shell
runsh() {
    # Get the source files
    files=()
    while IFS=  read -r -d $'\0'; do
        files+=("$REPLY")
    done < <(find "$PROJECT_SOURCES_PATH" -type f -name "*.sh" -print0)

    # Build the command line
    cmd=""
    for file in "${files[@]}"; do
        cmd="$cmd . $file;"
    done

    # Run the command in a subshell
    $BATS_SHELL -c "$cmd $@"
}

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
    /bin/echo "$@" | awk -f "$PROJECT_TESTS_PATH/unindent.awk"
}

# Assert equals, with a diff
assert_equal() {
    expected="$1"
    actual="$2"
    if [[ "$expected" != "$actual" ]]; then
        echo "$expected" > "$BATS_TMPDIR/expected"
        echo "$actual" > "$BATS_TMPDIR/actual"

        echo "Output does not match expectations"
        echo "--------------------------------------------------------------------------------"
        echo "Expected:"
        echo "$expected"
        echo "--------------------------------------------------------------------------------"
        echo "Actual:"
        echo "$actual"
        echo "--------------------------------------------------------------------------------"
        echo "Diff:"
        diff "$BATS_TMPDIR/expected" "$BATS_TMPDIR/actual"

        return 1
    fi
}

