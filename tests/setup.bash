#!/bin/sh

# Determine the shell to use
BATS_SHELL="${BATS_SHELL:-/bin/bash}"

# Get some paths
PROJECT_ROOT_PATH="${BATS_TEST_DIRNAME/\/tests*}"
PROJECT_SOURCES_PATH="$PROJECT_ROOT_PATH/src"
PROJECT_TESTS_PATH="$PROJECT_ROOT_PATH/tests"
ASCIIDOC_UTILS_PATH="$PROJECT_SOURCES_PATH"

# Load helper methods
load helpers/runsh
load helpers/unindent
load helpers/assert_equals

