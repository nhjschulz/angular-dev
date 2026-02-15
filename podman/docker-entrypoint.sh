#!/bin/sh
set -e

ng version

# If first arg looks like an option, prepend bash
if [ "${1#-}" != "$1" ]; then
  set -- bash "$@"
fi

if [ "$#" -eq 0 ]; then
  exec  bash
else
  exec "$@"
fi
