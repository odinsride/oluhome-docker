#!/bin/bash

PROGNAME="$(basename $0)"
WORKING_DIR="/home/sitheris/docker"

error_exit()
{
  curl -m 10 --retry 5 ${HCIO_B2_SYNC_FAIL_URL}
  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

# Load env variables
set -a
source ${WORKING_DIR}/.env || error_exit "Cannot find env file. Aborting."
set +a

# Auth B2
echo "${PROGNAME}: Authenticating with B2..."
${SYSTEM_BASE}/lib/b2 authorize-account ${B2_KEY_ID} ${B2_APP_KEY} || error_exit "Error authenticating."

# Sync Backups folder to B2
echo "${PROGNAME}: Syncing Backups to B2..."
${SYSTEM_BASE}/lib/b2 sync ${BACKUP_BASE} b2://${B2_BUCKET}/backups || error_exit "Error creating archive."

echo "${PROGNAME}: Backup complete."

# If we got this far, send a healthchecks ping
echo "${PROGNAME}: Pinging healthchecks.io..."
curl -m 10 --retry 5 ${HCIO_B2_SYNC_URL}