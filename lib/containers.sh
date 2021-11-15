#!/bin/bash
#
# Functions to start and stop containers

function up_containers() {
  log "INFO" "Starting containers..."
  docker-compose -f ${SYSTEM_BASE}/docker-compose.yml up -d || error_exit "Error starting containers."
  log "INFO" "Containers started."
}

function down_containers() {
  log "INFO" "Stopping containers..."
  docker-compose -f ${SYSTEM_BASE}/docker-compose.yml down || error_exit "Error stopping containers."
  log "INFO" "Containers stopped."
}

# Example usage
# . ./environment.sh
# envup
# down_containers
# up_containers