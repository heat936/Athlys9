#!/usr/bin/env bash
# Run private source checks without publishing their output in this public relay.
set -euo pipefail
umask 077
: "${RUNNER_TEMP:?RUNNER_TEMP is required}"
log_dir="$RUNNER_TEMP/athlys-private-logs"
mkdir -p -- "$log_dir"
private_log="$(mktemp "$log_dir/step.XXXXXX")"
trap 'rm -f -- "$private_log"' EXIT
if bash --noprofile --norc -e -u -o pipefail -s -- >"$private_log" 2>&1; then
  printf '%s\n' 'Private source step completed; detailed output is not published.'
else
  result=$?
  printf '%s\n' '::error::Private source step failed. Build stopped; private output was not published.' >&2
  exit "$result"
fi
