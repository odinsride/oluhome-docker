#!/bin/bash

PROGNAME="$(basename $0)"
WORKING_DIR="/home/sitheris/docker"

error_exit()
{
  curl -m 10 --retry 5 ${HCIO_APPDATA_BACKUP_FAIL_URL}
  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

# Load env variables
set -a
source ${WORKING_DIR}/.env || error_exit "Cannot find env file. Aborting."
set +a

# Shutdown Docker Containers
echo "${PROGNAME}: Stopping containers..."
docker-compose -f ${SYSTEM_BASE}/docker-compose.yml down || error_exit "Error stopping containers."

# Tar up the appdata directory
ARCHIVE_NAME=appdata-$(date -Is | tr : _).tar.gz
echo "${PROGNAME}: Creating archive - ${ARCHIVE_NAME}"
tar -czvf ${BACKUP_BASE}/appdata/${ARCHIVE_NAME} ${APPDATA_BASE}/ || error_exit "Error creating archive."

# Restart Docker Containers
echo "${PROGNAME}: Starting containers..."
docker-compose -f ${SYSTEM_BASE}/docker-compose.yml up -d || error_exit "Error starting containers."

# Remove old backups
find ${BACKUP_BASE}/appdata/ -type f -mtime +30 -name 'appdata*' -delete || error_exit "Error removing old backups."

echo "${PROGNAME}: Backup complete."

# If we got this far, send a healthchecks ping
echo "${PROGNAME}: Pinging healthchecks.io..."
curl -m 10 --retry 5 ${HCIO_APPDATA_BACKUP_URL}