#!/bin/bash
#
# Perform B2 syncing of a folder to a specified bucket/path

function b2sync() {
  source_path="${1}"
  dest_folder="${2}"

  b2auth

  log "INFO" "Syncing ${source_path} to B2..."
  ${SYSTEM_BASE}/lib/vendor/b2 sync ${source_path} b2://${B2_BUCKET}/${dest_folder} || error_return "Error syncing to B2."
  log "INFO" "Done"
}

function b2auth() {
  log "INFO" "Authenticating with B2..."
  ${SYSTEM_BASE}/lib/vendor/b2 authorize-account ${B2_KEY_ID} ${B2_APP_KEY} || error_return "Error authenticating."
  log "INFO" "Done."
}