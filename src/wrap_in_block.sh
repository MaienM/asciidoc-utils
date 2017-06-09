# Escape input for use in sed
# https://stackoverflow.com/a/2705678
_sed_escape() {
    echo "$@" | sed -e 's/[]\/$*.^|[]/\\&/g'
}

# Wrap in a block
adoc_wrap_in_block() {
    delim="$@"
    echo "$delim"
    # Insert a zero-width space before any line that's just the block delimiter
    # to prevent it from being picked up
    sed "s/^$(_sed_escape "$delim")$/$(echo -e "\u200B")&/"
    echo "$delim"
}
