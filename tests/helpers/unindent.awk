# Get the indentation of line
function getindent(line) {
    # Strip the indent
    _line = line
    sub(/^[ \t]+/, "", _line)
    # Use stripped length to determine the indent length
    l = length(line) - length(_line)
    # Get the indent
    return substr(line, 1, l)
}

# Given two strings, get the longest string of characters that appears at the
# start of both strings.
function getsharedprefix(l1, l2) {
    for (j = 1; j < length(l1); j++) {
        if (substr(l1, j, 1) != substr(l2, j, 1)) {
            return substr(l1, 1, j - 1)
        }
    }
    return l1
}

BEGIN {
    getline # Read first line
    getline # Read second line (skipping the empty first line)
    # Store all lines in an array
    linescount = 0
    do {
        lines[linescount++] = $0
    } while (getline)
    # Ignore the empty last line
    linescount--

    # Detect shared indent
    indent = getindent(lines[0])
    for (i = 0; i < linescount; i++) {
        # Ignore empty lines
        if (length(lines[i]) == 0) {
            continue
        }
        # Get the shared indent
        indent = getsharedprefix(indent, lines[i])
    }

    # Print all lines without the shared indent
    lindent = length(indent)
    for (i = 0; i < linescount; i++) {
        print substr(lines[i], lindent + 1)
    }
}

