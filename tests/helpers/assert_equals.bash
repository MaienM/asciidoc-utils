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

