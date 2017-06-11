#!/usr/bin/env bats

load setup

@test "adoc_add_to_header - simple header" {
    result=$(unindent "
        = Hello
    " | runsh 'adoc_add_to_header "Test"')
    expected=$(unindent "
        = Hello
        Test
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_add_to_header - no header" {
    result=$(unindent "
        Hello
    " | runsh 'adoc_add_to_header "Test"')
    expected=$(unindent "
        Test
        
        Hello
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_add_to_header - document with header" {
    result=$(unindent "
        = Hello
        World
        :test: 1
        
        == Foo
        
        Lorem Ipsum
    " | runsh 'adoc_add_to_header "Test"')
    expected=$(unindent "
        = Hello
        World
        :test: 1
        Test
        
        == Foo
        
        Lorem Ipsum
    ")
    assert_equal "$expected" "$result"
}

