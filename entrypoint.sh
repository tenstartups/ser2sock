#!/bin/sh
set -e

# Exit with error if SERIAL_DEVICE wasn't provided
if [ -z "${SERIAL_DEVICE}" ]; then
  echo >&2 "You must specify the SERIAL_DEVICE environment variable."
  exit 1
fi

exec ser2sock -f -p ${LISTENER_PORT} -s ${SERIAL_DEVICE} -i 0.0.0.0 -b ${BAUD_RATE}
