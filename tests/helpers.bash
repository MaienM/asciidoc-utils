# Run a command in the right shell
runsh() {
    # Get the source files
    files=()
    while IFS=  read -r -d $'\0'; do
        files+=("$REPLY")
    done < <(find "${BATS_TEST_DIRNAME/tests*}/src" -type f -name "*.sh" -print0)

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
    /bin/echo "$@" | awk '
        BEGIN {
            getline
            # Skip empty first line
            getline

            # Store all lines in an array, expect the last (empty) line
            lastline=$0
            while (getline) {
                lines[NR-2] = lastline
                lastline=$0
            }

            # Detect shared indent
            l = lines[1]
            sub(/^[ \t]+/, "", l)
            indent = substr(lines[1], 0, length(lines[1]) - length(l) + 1)
            for (i = 1; i < NR - 1; i++) {
                if (length(lines[i]) == 0) {
                    continue
                }
                for (j = 1; j < length(indent); j++) {
                    if (substr(indent, j, 1) != substr(lines[i], j, 1)) {
                        indent = substr(indent, 0, j)
                        break
                    }
                }
            }

            # Print all lines without the shared indent
            for (i = 1; i < NR - 1; i++) {
                sub("^" indent, "", lines[i])
                print lines[i]
            }
        }
    '
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

