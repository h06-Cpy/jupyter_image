#!/bin/bash
# Enhanced version to execute additional pre-start hooks

set -e

# Function to log messages
_log() {
    if [[ "$*" == "ERROR:"* ]] || [[ "$*" == "WARNING:"* ]] || [[ "${JUPYTER_DOCKER_STACKS_QUIET}" == "" ]]; then
        echo "$@"
    fi
}

_log "Entered start.sh with args:" "$@"

# Unset environment variables if specified
unset_explicit_env_vars() {
    if [ -n "${JUPYTER_ENV_VARS_TO_UNSET}" ]; then
        for env_var_to_unset in $(echo "${JUPYTER_ENV_VARS_TO_UNSET}" | tr ',' ' '); do
            _log "Unset ${env_var_to_unset} due to JUPYTER_ENV_VARS_TO_UNSET"
            unset "${env_var_to_unset}"
        done
        unset JUPYTER_ENV_VARS_TO_UNSET
    fi
}

# Default to starting bash if no command was specified
if [ $# -eq 0 ]; then
    cmd=( "bash" )
else
    cmd=( "$@" )
fi

# Execute hooks before starting the main command
_log "Executing hooks from /usr/local/bin/before-notebook.d"
source /usr/local/bin/run-hooks.sh /usr/local/bin/before-notebook.d

# Clean up environment
unset_explicit_env_vars

# Execute the command directly as root, no need to change user
_log "Executing the command as root:" "${cmd[@]}"
exec "${cmd[@]}"
