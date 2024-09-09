#!/bin/bash

if [ ! -d "$JENKINS_HOME/.venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$JENKINS_HOME/.venv"
    . "$JENKINS_HOME/.venv/bin/activate"
    pip install --upgrade pip
    pip install pytest-testinfra
    echo "Virtual environment setup complete."
else
    echo "Virtual environment already exists."
fi

export PATH="$JENKINS_HOME/.venv/bin:$PATH"

echo "export PATH=\"$JENKINS_HOME/.venv/bin:\$PATH\"" >> "$JENKINS_HOME/.bashrc"

exit 0
