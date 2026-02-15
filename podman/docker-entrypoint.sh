#!/bin/sh
set -e

ng version

echo "run ng serve --host 0.0.0.0 to service apps from a container."

# If first arg looks like an option, prepend bash
if [ "${1#-}" != "$1" ]; then
  set -- bash "$@"
fi

if [ "$#" -eq 0 ]; then
  exec  bash
else
  exec "$@"
fi
