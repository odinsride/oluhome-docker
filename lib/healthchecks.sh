#!/bin/bash
#
# Function to ping healthchecks.io

function hc_ping() {
  log "INFO" "Pinging healthchecks.io for ${1}"
  curl -m 10 --retry 5 ${2} || log "WARN" "Error pinging healthchecks.io"
}

function hc_ping_fail() {
  url="${2}/fail"
  log "WARN" "Pinging healthchecks.io FAILURE for ${1}"
  curl -m 10 --retry 5 ${url} || log "WARN" "Error pinging healthchecks.io"
}

# Example usage
# hc_ping "Healthchecks endpoint description" "http://hc-ping.com/<UUID>"