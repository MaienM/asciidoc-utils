# Add to the header of a report
adoc_add_to_header() {
    awk -v extra="$@" '
        {
            # If the first line does not start with "= ", there is no header, so
            # create one
            if (NR == 1 && !/^= /) {
                print extra
                print ""
                extra = ""
            }

            # First empty line, marking the end of header
            if (/^$/ && length(extra) > 0) {
                print extra
                extra = ""
            }

            # Pass input through
            print
        }

        END {
            if (length(extra) > 0) {
                print extra
            }
        }
    '
}
