#!/bin/bash

set -e errexit -e pipefail -e nounset

apk add --no-cache \
    bats loksh mksh zsh gawk sed
apk add --no-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    --allow-untrusted \
    dash

declare -A SHELLS AWKS SEDS
SHELLS=(
    [busybox sh]="/bin/busybox sh"
    [bash]=/bin/bash
    [bash-posix]="/bin/bash --posix"
    [dash]=/bin/dash
    [loksh]=/bin/loksh
    [mksh]=/bin/mksh
    [zsh]=/bin/zsh
)
DEPENDENCIES=(awk sed)
AWKS=(
    [busybox awk]="/bin/busybox awk"
    [gnu awk]=/usr/bin/gawk
)
SEDS=(
    [busybox sed]="/bin/busybox sed"
    [gnu sed]=/bin/sed
)

failed=0

export ASCIIDOC_UTILS_PATH="$PWD/src"

echo
echo "== Shells"
for shell_name in "${!SHELLS[@]}"; do
    echo
    echo "=== $shell_name"
    echo
    BATS_SHELL="${SHELLS[$shell_name]}"
    bats tests || failed=1
done
unset BATS_SHELL

for dep in "${DEPENDENCIES[@]}"; do
    echo
    echo "== \`$dep\`"
    mkdir -p bin
    varname="$(echo "${dep}s" | tr /a-z/ /A-Z/)"
    eval "$(declare -p $varname | sed "s/$varname/TEMP/")"
    for prog_name in "${!TEMP[@]}"; do
        echo
        echo "=== $prog_name"
        echo
        prog="${TEMP[$prog_name]}"
        echo "#!/bin/sh" > bin/$dep
        echo "$prog "'"$@"' >> bin/$dep
        chmod +x bin/$dep
        PATH="$PWD/bin:$PATH" bats tests || failed=1
    done
    rm -rf bin
done

exit $failed
