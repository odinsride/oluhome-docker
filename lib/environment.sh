#!/bin/bash
#
# Environment setup: Loads the .env file from parent directory

function envup() {
  log "INFO" "Loading environment variables..."
  pushd `dirname $0` > /dev/null
  script_path=`pwd`
  popd > /dev/null

  set -a
  source "${script_path}/../.env" || error_exit "Cannot find env file. Aborting."
  set +a
  log "INFO" "Done."
}

# Example usage
# envup