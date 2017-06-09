#!/usr/bin/env bats

setup() {
    load "source"
    load "asserts"
}

@test "adoc_strip_header - simple header" {
    result=$((
        echo "= Hello"
        ) | adoc_strip_header)
    expected=""
    assert_equal "$expected" "$result"
}

@test "adoc_strip_header - no header" {
    result=$((
        echo "Hello"
    ) | adoc_strip_header)
    expected=$(
        echo "Hello"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_strip_header - document with header" {
    result=$((
        echo "= Hello"
        echo "World"
        echo ":test: 1"
        echo
        echo "== Foo"
        echo
        echo "Lorem Ipsum"
    ) | adoc_strip_header)
    expected=$(
        echo "== Foo"
        echo
        echo "Lorem Ipsum"
    )
    assert_equal "$expected" "$result"
}
