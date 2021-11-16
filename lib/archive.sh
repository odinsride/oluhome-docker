#!/bin/bash
#
# Functions to create archives and manage archive retention

function create_archive() {
  archive_prefix="${1}"
  archive_source_path="${2}"
  archive_name="${archive_prefix}-$(date -Is | tr : _).tar.gz"
  log "INFO" "Creating archive - ${archive_name}..."
  tar --exclude="${archive_source_path}/gitea" -czf ${BACKUP_BASE}/${archive_prefix}/${archive_name} ${archive_source_path}/ || error_return "Error creating archive."
  log "INFO" "Archive created."
  prune_archive ${archive_prefix}
}

function prune_archive() {
  archive_prefix="${1}"
  log "INFO" "Pruning old ${archive_prefix} archives..."
  find ${BACKUP_BASE}/${archive_prefix}/ -type f -mtime +30 -name "${archive_prefix}*" -delete || error_return "Error removing old archives."
  log "INFO" "Done."
}