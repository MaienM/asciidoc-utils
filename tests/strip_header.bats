#!/usr/bin/env bats

load setup

@test "adoc_strip_header - simple header" {
    result=$(unindent "
        = Hello
    " | runsh 'adoc_strip_header')
    expected=""
    assert_equal "$expected" "$result"
}

@test "adoc_strip_header - no header" {
    result=$(unindent "
        Hello
    " | runsh 'adoc_strip_header')
    expected=$(unindent "
        Hello
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_strip_header - document with header" {
    result=$(unindent "
        = Hello
        World
        :test: 1
        
        == Foo
        
        Lorem Ipsum
    " | runsh 'adoc_strip_header')
    expected=$(unindent "
        == Foo
        
        Lorem Ipsum
    ")
    assert_equal "$expected" "$result"
}

