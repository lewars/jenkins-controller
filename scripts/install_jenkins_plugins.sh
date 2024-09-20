#!/usr/bin/env bash

#
# install_jenkins_plugins.sh - A script to install Jenkins plugins from a
# plugins.txt file and generate a list of installed plugins with their versions.

set -e

PLUGINS_FILE="plugins.txt"
INSTALLED_PLUGINS_FILE="plugins-installed.txt"

if [ ! -f "$PLUGINS_FILE" ]; then
    echo "Error: $PLUGINS_FILE not found!"
    exit 1
fi

echo "Installing plugins from $PLUGINS_FILE..."
jenkins-plugin-cli --plugin-file "$PLUGINS_FILE"

echo "Generating list of installed plugins with versions..."
echo "# Jenkins controller base image: ${BASE_IMAGE}" > "$INSTALLED_PLUGINS_FILE"
jenkins-plugin-cli --list --output txt | sort >> "$INSTALLED_PLUGINS_FILE"

echo "Installation complete. List of installed plugins saved to $INSTALLED_PLUGINS_FILE"

echo "Installed plugins:"
cat "$INSTALLED_PLUGINS_FILE"
