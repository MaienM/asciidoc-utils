# Run a command in the right shell
runsh() {
    # Run the command in a subshell
    $BATS_SHELL -c ". '$PROJECT_SOURCES_PATH/main.sh'; $@"
}

