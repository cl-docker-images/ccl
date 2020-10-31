#!/bin/sh

# If the first arg starts with a hyphen, prepend ccl to arguments.
if [ "${1#-}" != "$1" ]; then
	set -- ccl "$@"
fi

exec "$@"
