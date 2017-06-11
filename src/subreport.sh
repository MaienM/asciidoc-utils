# Prepare a report to be nested in another report
#
# This means, remove the header, and modify all titles to be one (or more)
# levels deeper
adoc_subreport() {
    levels=$((${1:-1} + 0))
    header_prefix=""
    for ((i=0; i< $levels; i++)); do
        header_prefix="$header_prefix="
    done
    adoc_strip_header | sed "s/^=/$header_prefix&/"
}

