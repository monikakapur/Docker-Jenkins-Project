#!/bin/bash
set -e
mkdir -p .devcontainer
cat << 'EOF' > .devcontainer/devcontainer.json
{
"name": "$Codespace_name",
"features": {
"ghcr.io/devcontainers/features/docker-in-docker:2":{}
}
}
echo "Devcontainer configuration created successfully with your codespace name!"