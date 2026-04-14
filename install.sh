#!/bin/sh
set -e

# Prevent execution if this script was only partially downloaded
{
    OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m)"
    [ "$ARCH" = "x86_64" ] && ARCH="amd64"
    [ "$ARCH" = "aarch64" ] && ARCH="arm64"

    if ! command -v curl >/dev/null 2>&1; then
        echo "Error: curl is required to install toofan."
        exit 1
    fi

    echo "Fetching latest toofan..."
    URL="https://github.com/vyrx-dev/toofan/releases/latest/download/toofan-${OS}-${ARCH}"

    if ! curl -sfL "$URL" -o /tmp/toofan; then
        echo "Error: Release not found for ${OS}-${ARCH}."
        exit 1
    fi
    chmod +x /tmp/toofan

    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
    mv /tmp/toofan "$INSTALL_DIR/toofan"

    echo "Installed to $INSTALL_DIR/toofan"
    
    # Export it to PATH temporarily so it runs immediately
    export PATH="$INSTALL_DIR:$PATH"
    
    sleep 0.5
    toofan
}
