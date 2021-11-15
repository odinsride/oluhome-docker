#!/bin/bash
#
# Logging function with date/time support, script name support, and color output

script_name="$(basename $0)"

declare -A colors
colors=(
    ["grey"]="0"
    ["red"]="31"
    ["white"]="1;37"
    ["yellow"]="33")

function log() {
    m_time=`date "+%F %T"`

    function colorprint() {
        # $1 = color number, for example 31, 33, 1;37
        # $2 = message to be echoed
        echo -e "\033[$1m$2\033[0m" 
    }

    function logline() {
        colorprint $1 "[$m_time] ($script_name) $2: $3"
    }

    case $1 in
        INFO)
            logline ${colors["white"]} "$1" "$2" ;;
        WARN)
            logline ${colors["yellow"]} "$1" "$2" >&2 ;;
        ERROR)
            logline ${colors["red"]} "$1" "$2" >&2 ;;
        DEBUG)
            logline ${colors["grey"]} "$1" "$2" ;;
        *)
            log "ERROR" "unknown log level"
            return 1
            ;;
    esac
}

# Example usage
# log "test"
# log "WARN" "warning, there is some uncertainty at the moment"
# log "ERROR" "something just went haywire"
# log "INFO" "executing some task, all according to plan"
# log "DEBUG" "with some additional fine-grained information"