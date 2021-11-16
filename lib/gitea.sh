#!/bin/bash
#
# Perform Gitea Dump

function gitea_dump() {
  log "INFO" "Backing up Gitea..."
  docker exec -u git -it -w /tmp $(docker ps -qaf "name=^/gitea$") sh -c '/app/gitea/gitea dump -c /data/gitea/conf/app.ini' || error_return "Gitea dump failed"
  echo "${ROOT_PW}" | sudo -S chmod -R 775 ${BACKUP_BASE}/gitea/
  find ${BACKUP_BASE}/gitea/ -type f -mtime +30 -name "${gitea-dump}*" -delete || error_return "Error removing old archives."
  log "INFO" "Done."
}