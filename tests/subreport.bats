#!/usr/bin/env bats

setup() {
    load "source"
    load "asserts"
}

@test "adoc_subreport - simple title" {
    result=$((
        echo "== Hello"
        echo
        echo "Lorem Ipsum"
        ) | adoc_subreport)
    expected=$(
        echo "=== Hello"
        echo
        echo "Lorem Ipsum"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_subreport - simple title - 3 levels" {
    result=$((
        echo "== Hello"
        echo
        echo "Lorem Ipsum"
        ) | adoc_subreport 3)
    expected=$(
        echo "===== Hello"
        echo
        echo "Lorem Ipsum"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_subreport - with subtitle" {
    result=$((
        echo "== Hello"
        echo
        echo "=== World"
        echo
        echo "Lorem Ipsum"
        ) | adoc_subreport)
    expected=$(
        echo "=== Hello"
        echo
        echo "==== World"
        echo
        echo "Lorem Ipsum"
    )
    assert_equal "$expected" "$result"
}

@test "adoc_subreport - document with header" {
    result=$((
        echo "= Hello"
        echo "World"
        echo ":test: 1"
        echo
        echo "== Foo"
        echo
        echo "Lorem Ipsum"
    ) | adoc_subreport)
    expected=$(
        echo "=== Foo"
        echo
        echo "Lorem Ipsum"
    )
    assert_equal "$expected" "$result"
}
