#!/bin/bash
#=============================================================================
#          FILE: install-eSim.sh
# 
#         USAGE: ./install-eSim.sh --install 
#                            OR
#                ./install-eSim.sh --uninstall
#                
#   DESCRIPTION: Installation script for eSim EDA Suite
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#       AUTHORS: Fahim Khan, Rahul Paknikar, Saurabh Bansode,
#                Sumanto Kar, Partha Singha Roy, Jayanth Tatineni,
#                Anshul Verma, Shiva Krishna Sangati, Harsha Narayana P
#  ORGANIZATION: eSim Team, FOSSEE, IIT Bombay
#       CREATED: Sunday 25 May 2025 17:40
#      REVISION: ---
#=============================================================================

# Function to detect Ubuntu version and full version string
if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "/etc/os-release not found."
    exit 1
fi

VERSION_ID="$VERSION_ID"
FULL_VERSION="$VERSION"

echo "Detected Ubuntu Version: $VERSION_ID ($FULL_VERSION)"


# Function to choose and run the appropriate script
run_version_script() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/install-eSim-scripts"
    
    # Decide script based on full version
case "$VERSION_ID" in
    "22.04")
        SCRIPT="$SCRIPT_DIR/install-eSim-22.04.sh"
        ;;
    "23.04")
        SCRIPT="$SCRIPT_DIR/install-eSim-23.04.sh"
        ;;
    "24.04")
        SCRIPT="$SCRIPT_DIR/install-eSim-24.04.sh"
        ;;
    "25.04"|"25.10")
        echo "Ubuntu $VERSION_ID detected. Using 25.04 installer with compatibility fixes."
        SCRIPT="$SCRIPT_DIR/install-eSim-25.04.sh"
        ;;
    *)
       
        echo "Supported versions: 22.04, 23.04, 24.04, 25.04+"
        exit 1
        ;;
esac

    # Run the script if found
    if [[ -f "$SCRIPT" ]]; then
        echo "Running script: $SCRIPT $ARGUMENT"
        bash "$SCRIPT" "$ARGUMENT"
    else
        echo "Installation script not found: $SCRIPT"
        exit 1
    fi
}

# --- Main Execution Starts Here ---

# Validate argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 --install | --uninstall"
    exit 1
fi

ARGUMENT=$1
if [[ "$ARGUMENT" != "--install" && "$ARGUMENT" != "--uninstall" ]]; then
    echo "Invalid argument: $ARGUMENT"
    echo "Usage: $0 --install | --uninstall"
    exit 1
fi


run_version_script