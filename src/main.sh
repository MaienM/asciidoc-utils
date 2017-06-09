# Get the path to the current folder
# This is not 100% portable, but most distributions come with a readlink that does support -f
# An exception to this is OSX, where you'll have to `brew install coreutils` and use greadlink
cf="$(dirname "$(readlink -f "$BASH_SOURCE[0]")")"

source "$cf/add_to_header.sh"
source "$cf/strip_header.sh"
source "$cf/subreport.sh"
source "$cf/wrap_in_block.sh"
