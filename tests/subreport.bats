#!/usr/bin/env bats

load setup

@test "adoc_subreport - simple title" {
    result=$(unindent "
        == Hello
        
        Lorem Ipsum
    " | runsh 'adoc_subreport')
    expected=$(unindent "
        === Hello
        
        Lorem Ipsum
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_subreport - simple title - 3 levels" {
    result=$(unindent "
        == Hello
        
        Lorem Ipsum
    " | runsh 'adoc_subreport 3')
    expected=$(unindent "
        ===== Hello
        
        Lorem Ipsum
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_subreport - with subtitle" {
    result=$(unindent "
        == Hello
        
        === World
        
        Lorem Ipsum
    " | runsh 'adoc_subreport')
    expected=$(unindent "
        === Hello
        
        ==== World
        
        Lorem Ipsum
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_subreport - document with header" {
    result=$(unindent "
        = Hello
        World
        :test: 1
        
        == Foo
        
        Lorem Ipsum
    " | runsh 'adoc_subreport')
    expected=$(unindent "
        === Foo
        
        Lorem Ipsum
    ")
    assert_equal "$expected" "$result"
}

