#!/bin/sh

echo "Running entrypoint script"
exec "$@" && echo "Completed [$@]" || echo "Failed [$@]"

