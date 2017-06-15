BEGIN {
	done = 0
}
{
	# If the first line does not start with "= ", there is no header
	if (NR == 1 && !/^= /) { done = 1 }
	if (!done && /^$/) { done = 1; next }
	if (!done) { next }
	print
}

