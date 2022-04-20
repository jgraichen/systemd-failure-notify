#!/bin/sh

# Notify of service failures via email.
#
# Usage: Add the following snippet to a service, for example, via a
# drop-in snippet.
#
#     [Service]
#     ExecStopPost=+/usr/bin/systemd-failure-notify "%n"
#

# Do nothing if service exited successfully
[ "${SERVICE_RESULT}" = "success" ] && exit 0

if [ -z "${INVOCATION_ID}" ]; then
    echo "ERROR: INVOCATION_ID missing" >&2
    exit 1
fi

SERVICE_NAME="${1}"
MAILTO=${MAILTO:-"root"}

if [ -z "${SERVICE_NAME}" ]; then
    echo "ERROR: SERVICE_NAME argument empty" >&2
    exit 1
fi

SUBJECT="${SERVICE_NAME} failed: ${SERVICE_RESULT} (${EXIT_STATUS})"
LOG_OUTPUT=$(journalctl _SYSTEMD_INVOCATION_ID="${INVOCATION_ID}")

/usr/bin/mail -s "${SUBJECT}" "${MAILTO}" <<EOF
${LOG_OUTPUT}
EOF
