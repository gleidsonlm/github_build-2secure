#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

venv_name="appdome_virtual_env"
requirements_file="./appdome/requirements.txt"

activate_virtual_env() {
    if [ ! -d "$venv_name" ]; then
        echo "Virtual environment '$venv_name' not found. Creating..."
        python3 -m venv "$venv_name"
    else
        echo "Using existing virtual environment '$venv_name'."
    fi

    if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
        # Unix/Linux/macOS
        source "$venv_name/bin/activate"
    elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* ]]; then
        # Windows
        source "$venv_name/Scripts/activate"
    else
        echo "Unsupported OS."
        exit 1
    fi

    if [ -f "$requirements_file" ]; then
        pip3 install -r "$requirements_file"
        echo "Requirements installed from '$requirements_file'."
    else
        echo "Requirements file '$requirements_file' not found."
        exit 1
    fi
}

activate_virtual_env
