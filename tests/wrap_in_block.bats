#!/usr/bin/env bats

load setup

@test "adoc_wrap_in_block - simple text" {
    result=$(unindent "
        Lorem Ipsum
    " | runsh 'adoc_wrap_in_block "----"')
    expected=$(unindent "
        ----
        Lorem Ipsum
        ----
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - with empty lines" {
    result=$(unindent "
        Lorem Ipsum

        Dolor Sit Amet

    " | runsh 'adoc_wrap_in_block "----"')
    expected=$(unindent "
        ----
        Lorem Ipsum

        Dolor Sit Amet

        ----
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - containing block delimiter" {
    zws=$(printf "\342\200\213\012")
    result=$(unindent "
        Lorem Ipsum
        ----
        Dolor Sit Amet
    " | runsh 'adoc_wrap_in_block "----"')
    expected=$(unindent "
        ----
        Lorem Ipsum
        ${zws}----
        Dolor Sit Amet
        ----
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - containing not quite block delimiter" {
    result=$(unindent "
        Lorem Ipsum
        ------
        Dolor Sit Amet
    " | runsh 'adoc_wrap_in_block "----"')
    expected=$(unindent "
        ----
        Lorem Ipsum
        ------
        Dolor Sit Amet
        ----
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - special delimiter" {
    result=$(unindent "
        Lorem Ipsum
    " | runsh 'adoc_wrap_in_block "...."')
    expected=$(unindent "
        ....
        Lorem Ipsum
        ....
    ")
    assert_equal "$expected" "$result"
}

@test "adoc_wrap_in_block - special delimiter is escaped properly" {
    result=$(unindent "
        ----
    " | runsh 'adoc_wrap_in_block "...."')
    expected=$(unindent "
        ....
        ----
        ....
    ")
    assert_equal "$expected" "$result"
}

