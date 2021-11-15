#!/bin/bash
#
# Error handling

function log_error() {
  log "ERROR" "${1:-"Unknown Error"}" 1>&2
}

function error_exit() {
  # curl -m 10 --retry 5 ${HCIO_APPDATA_BACKUP_FAIL_URL}
  log_error "${1}"
  exit 1
}

function error_return() {
  log_error "${1}"
  return 1
}

# Example usage
# error_exit "An error occured"