#!/bin/bash
set -e
mkdir -p .devcontainer
cat << EOF > .devcontainer/devcontainer.json
{
"name": "$Codespace_name",
"features": {
"ghcr.io/devcontainers/features/docker-in-docker":{}
}
}
EOF
