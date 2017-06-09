#!/usr/bin/env bats

setup() {
    load "source"
    load "asserts"
}

@test "adoc_wrap_in_block - simple text" {
    result=$((
        echo "Lorem Ipsum"
    ) | adoc_wrap_in_block "----")
    expected=$(
        echo "----"
        echo "Lorem Ipsum"
        echo "----"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - with empty lines" {
    result=$((
        echo "Lorem Ipsum"
        echo
        echo "Dolor Sit Amet"
        echo
    ) | adoc_wrap_in_block "----")
    expected=$(
        echo "----"
        echo "Lorem Ipsum"
        echo
        echo "Dolor Sit Amet"
        echo
        echo "----"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - containing block delimiter" {
    result=$((
        echo "Lorem Ipsum"
        echo "----"
        echo "Dolor Sit Amet"
    ) | adoc_wrap_in_block "----")
    expected=$(
        echo "----"
        echo "Lorem Ipsum"
        echo -e "\u200B----"
        echo "Dolor Sit Amet"
        echo "----"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - containing not quite block delimiter" {
    result=$((
        echo "Lorem Ipsum"
        echo "------"
        echo "Dolor Sit Amet"
    ) | adoc_wrap_in_block "----")
    expected=$(
        echo "----"
        echo "Lorem Ipsum"
        echo "------"
        echo "Dolor Sit Amet"
        echo "----"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - special delimiter" {
    result=$((
        echo "Lorem Ipsum"
    ) | adoc_wrap_in_block "....")
    expected=$(
        echo "...."
        echo "Lorem Ipsum"
        echo "...."
    )
    assert_equal "$expected" "$result"
}
