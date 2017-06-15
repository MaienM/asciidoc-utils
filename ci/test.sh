#!/bin/bash

set -e errexit -e pipefail -e nounset

apk add --no-cache \
    bats \
    loksh mksh zsh \
    gawk
apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    dash

SHELLS=(
    /bin/sh
    /bin/bash
    "/bin/bash --posix"
    /bin/dash
    /bin/loksh
    /bin/mksh
    /bin/zsh
)
AWKS=(
    /usr/bin/gawk
)

failed=0

echo
echo "== Shells"
for BATS_SHELL in "${SHELLS[@]}"; do
    echo
    echo "=== $BATS_SHELL"
    echo
    bats tests || failed=1
done

echo
echo "== Awks"
mkdir -p bin
for awk in "${AWKS[@]}"; do
    echo
    echo "=== $awk"
    echo
    ln -sf "$awk" bin/awk
    PATH="$PWD/bin:$PATH" bats tests || failed=1
done

exit $failed
