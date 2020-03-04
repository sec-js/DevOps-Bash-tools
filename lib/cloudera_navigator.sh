#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-01-23 15:08:10 +0000 (Thu, 23 Jan 2020)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# Quick lib to be sourced for auto-populating Cloudera Navigator details in a script

# Tested on Cloudera Enterprise 5.10

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

if [ -z "${CLOUDERA_NAVIGATOR:-}" ]; then
    if [ -n "${CLOUDERA_NAVIGATOR_HOST:-}" ]; then
        CLOUDERA_NAVIGATOR="${CLOUDERA_NAVIGATOR_HOST:-}:${CLOUDERA_NAVIGATOR_PORT:-7180}"
    else
        read -r -p 'Enter Cloudera Navigator host URL: ' CLOUDERA_NAVIGATOR
    fi
fi

export USER="${CLOUDERA_NAVIGATOR_USER:-${CLOUDERA_USER:-${USER:-}}}"
export PASSWORD="${CLOUDERA_NAVIGATOR_PASSWORD:-${CLOUDERA_PASSWORD:-${PASSWORD:-}}}"

if [ -n "${CLOUDERA_NAVIGATOR_SSL:-}" ]; then
    CLOUDERA_NAVIGATOR="https://${CLOUDERA_NAVIGATOR#*://}"
    if [[ "$CLOUDERA_NAVIGATOR" =~ :7186$ ]]; then
        CLOUDERA_NAVIGATOR="${CLOUDERA_NAVIGATOR%:7186}:7187"
    fi
fi

# shellcheck disable=SC2034
# Navigator expects timestamp in millis
now_timestamp="$(date +%s000)"
