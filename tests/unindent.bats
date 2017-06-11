#!/usr/bin/env bats

load setup

@test "unindent - single line" {
    result=$(unindent "
        Lorem Ipsum
    ")
    expected="Lorem Ipsum"
    assert_equal "$expected" "$result"
}

@test "unindent - escape sequences" {
    result=$(unindent "
        Lorem Ipsum\t
    ")
    expected="Lorem Ipsum\t"
    assert_equal "$expected" "$result"
}

@test "unindent - multiline" {
    result=$(unindent "
        Lorem Ipsum

        Dolor Sit Amet
    ")
    expected=$(
        echo "Lorem Ipsum"
        echo
        echo "Dolor Sit Amet"
    )
    assert_equal "$expected" "$result"
}

@test "unindent - multiline w/mixed indent levels" {
    result=$(unindent "
        Lorem Ipsum

            Dolor Sit Amet
    ")
    expected=$(
        echo "Lorem Ipsum"
        echo
        echo "    Dolor Sit Amet"
    )
    assert_equal "$expected" "$result"
}

@test "unindent - multiline w/mixed indent levels diffent order" {
    result=$(unindent "
            Lorem Ipsum

        Dolor Sit Amet
    ")
    expected=$(
        echo "    Lorem Ipsum"
        echo
        echo "Dolor Sit Amet"
    )
    assert_equal "$expected" "$result"
}

@test "unindent - multiline w/mixed tabs/spaces" {
    tab=$(printf "\t")
    result=$(unindent "
        ${tab}Lorem Ipsum

        ${tab}Dolor Sit Amet
    ")
    expected=$(
        echo "Lorem Ipsum"
        echo
        echo "Dolor Sit Amet"
    )
    assert_equal "$expected" "$result"
}

