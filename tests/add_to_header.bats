#!/usr/bin/env bats

setup() {
    load "source"
    load "asserts"
}

@test "adoc_add_to_header - simple header" {
    result=$((
        echo "= Hello"
    ) | adoc_add_to_header "Test")
    expected=$(
        echo "= Hello"
        echo "Test"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_add_to_header - no header" {
    result=$((
        echo "Hello"
    ) | adoc_add_to_header "Test")
    expected=$(
        echo "Test"
        echo
        echo "Hello"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_add_to_header - document with header" {
    result=$((
        echo "= Hello"
        echo "World"
        echo ":test: 1"
        echo
        echo "== Foo"
        echo
        echo "Lorem Ipsum"
    ) | adoc_add_to_header "Test")
    expected=$(
        echo "= Hello"
        echo "World"
        echo ":test: 1"
        echo "Test"
        echo
        echo "== Foo"
        echo
        echo "Lorem Ipsum"
    )
    assert_equal "$expected" "$result"
}
