# Add to the header of a report
adoc_add_to_header() {
    awk -v extra="$@" -f "$ASCIIDOC_UTILS_PATH/add_to_header.awk"
}

