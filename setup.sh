#!/bin/bash

# This is a Python Project Bootstrapper

set -e   # This stops code from running on any error

LOG_FILE="setup.log"
touch "$LOG_FILE"       # This stores logs of the setup process

# Color Codes for process display
CYAN="\033[1;36m"      # Info color
GREEN="\033[1;32m"     # Success color
YELLOW="\033[1;33m"    # Warning color
RED="\033[1;31m"     # Error color
RESET="\033[0m"      # Reset all attributes

# Logging Functions

log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

info() {
    log "${CYAN}[INFO]${RESET} $1"
}

success() {
    log "${GREEN}[SUCCESS]${RESET} $1"
}

warning() {
    log "${YELLOW}[WARNING]${RESET} $1" 
}

error() {
    log "${RED}[ERROR]${RESET} $1"
}

# Check or create Python virtual environment with activation

check_or_create_venv() {
    info "Checking for Python virtual environment."

    if [ -d ".venv" ]; then
        success "Python virtual environment already exists."
    else
        info "Creating virtual environment..."
        python3 -m venv .venv >> "$LOG_FILE" 2>&1
        success "Virtual environment created."
    fi

    info "Activating virtual environment..."       # Activate venv in this script only
    source .venv/bin/activate
    success "Virtual environment activated."
}

# Upgrade pip inside venv 

upgrade_pip() {
    info "Upgrading pip inside virtual environment..."
    .venv/bin/python -m pip install --upgrade pip >> "$LOG_FILE" 2>&1
    success "Pip upgrade successful."
}

# Generate .gitignore file with addition of standard Python ignores rules

generate_gitignore() {
    info "Checking for .gitignore file..."

    if [ -f ".gitignore" ]; then
        warning ".gitignore already exists."
    else
        info ".gitignore does not exist."
        touch .gitignore
        success ".gitignore file created."
    fi
    
    cat << EOF > .gitignore
# Python virtual environment
.venv/

# Bytecode
__pycache__/
*.pyc
*.pyo
*.pyd

# Logs
*.log

# Environment variables
.env

# Build artifacts
build/
dist/

# IDE-specific
.vscode/
.idea/
EOF

    success ".gitignore file created with standard ignore rules added."
}

# Install Python Packages  (numpy, pandas, requests, SQLAlchemy, boto3) 

install_python_packages() {
    info "Installing Python packages..."

    .venv/bin/python -m pip install numpy pandas requests SQLAlchemy boto3 | tee -a "$LOG_FILE"

    success "Python packages installed successfully."
}

# Main Function

main() {
    info "Starting project setup..."

    check_or_create_venv
    upgrade_pip
    generate_gitignore
    install_python_packages

    success "Project setup completed successfully!"
    success "Log file saved to $LOG_FILE"
}

main
