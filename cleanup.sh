#!/usr/bin/env bash

# Exit on errors
set -e
# Apt maintenance
apt-get autoremove -y
apt-get clean -y

# Ignore non-zero exit codes
set +e
# Remove unused docker images
docker images -q --filter "dangling=true" | xargs docker rmi
# Remove unused docker containers
docker ps -a | grep -v 'CONTAINER\|_config\|_data\|_run' | cut -c-12 | xargs docker rm
# Ignore expected error code from docker and exit
exit 0