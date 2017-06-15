# Strip the header of a report
adoc_strip_header() {
    awk -f "$ASCIIDOC_UTILS_PATH/strip_header.awk"
}

