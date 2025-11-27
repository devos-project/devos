#!/bin/sh
# DevOS Installation Script
# https://github.com/devos-project/devos

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# GitHub repository
GITHUB_REPO="devos-project/devos"
GITHUB_API="https://api.github.com/repos/${GITHUB_REPO}/releases/latest"

# Detect OS
detect_os() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    case "$OS" in
        linux*)  OS="linux" ;;
        darwin*) OS="darwin" ;;
        *)
            printf "${RED}Error: Unsupported operating system: $OS${NC}\n" >&2
            printf "DevOS currently supports Linux and macOS.\n" >&2
            exit 1
            ;;
    esac
}

# Detect architecture
detect_arch() {
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  ARCH="amd64" ;;
        amd64)   ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
        arm64)   ARCH="arm64" ;;
        *)
            printf "${RED}Error: Unsupported architecture: $ARCH${NC}\n" >&2
            printf "DevOS currently supports amd64 and arm64.\n" >&2
            exit 1
            ;;
    esac
}

# Determine install location
determine_install_location() {
    # Prefer /usr/local/bin if writable, otherwise use ~/.local/bin
    if [ -w "/usr/local/bin" ]; then
        INSTALL_DIR="/usr/local/bin"
    else
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"

        # Check if ~/.local/bin is in PATH
        case ":$PATH:" in
            *":$INSTALL_DIR:"*) ;;
            *)
                printf "${YELLOW}Note: $INSTALL_DIR is not in your PATH${NC}\n"
                printf "Add the following line to your shell profile (~/.bashrc, ~/.zshrc, etc.):\n"
                printf "  export PATH=\"\$PATH:$INSTALL_DIR\"\n\n"
                ;;
        esac
    fi
}

# Fetch latest release information
fetch_latest_release() {
    printf "${BLUE}Fetching latest release information...${NC}\n"

    # Fetch release data from GitHub API
    RELEASE_DATA=$(curl -fsSL "$GITHUB_API" 2>/dev/null || {
        printf "${RED}Error: Failed to fetch release information from GitHub${NC}\n" >&2
        printf "Please check your internet connection and try again.\n" >&2
        exit 1
    })

    # Extract tag name and download URL
    TAG_NAME=$(echo "$RELEASE_DATA" | grep '"tag_name"' | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/')

    if [ -z "$TAG_NAME" ]; then
        printf "${RED}Error: Could not determine latest version${NC}\n" >&2
        exit 1
    fi

    # Construct binary name and download URL
    BINARY_NAME="devos-${OS}-${ARCH}"
    DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/download/${TAG_NAME}/${BINARY_NAME}"

    printf "${GREEN}Latest version: ${TAG_NAME}${NC}\n"
}

# Download checksums file
download_checksums() {
    printf "${BLUE}Downloading checksums...${NC}\n"

    CHECKSUMS_FILE="devos-${TAG_NAME}-checksums.txt"
    CHECKSUMS_URL="https://github.com/${GITHUB_REPO}/releases/download/${TAG_NAME}/${CHECKSUMS_FILE}"
    TMP_CHECKSUMS=$(mktemp)

    if ! curl -fsSL -o "$TMP_CHECKSUMS" "$CHECKSUMS_URL"; then
        rm -f "$TMP_CHECKSUMS"
        printf "${YELLOW}Warning: Could not download checksums file${NC}\n"
        printf "Skipping checksum verification.\n"
        SKIP_CHECKSUM=1
        return 0
    fi

    CHECKSUMS_PATH="$TMP_CHECKSUMS"
}

# Verify binary checksum
verify_checksum() {
    if [ "$SKIP_CHECKSUM" = "1" ]; then
        printf "${YELLOW}⚠ Checksum verification skipped${NC}\n"
        return 0
    fi

    printf "${BLUE}Verifying checksum...${NC}\n"

    # Extract expected checksum for our binary
    EXPECTED_CHECKSUM=$(grep "$BINARY_NAME" "$CHECKSUMS_PATH" | awk '{print $1}')

    if [ -z "$EXPECTED_CHECKSUM" ]; then
        printf "${YELLOW}Warning: Could not find checksum for ${BINARY_NAME}${NC}\n"
        printf "Skipping checksum verification.\n"
        rm -f "$CHECKSUMS_PATH"
        return 0
    fi

    # Calculate actual checksum
    if command -v sha256sum >/dev/null 2>&1; then
        ACTUAL_CHECKSUM=$(sha256sum "$TMP_FILE" | awk '{print $1}')
    elif command -v shasum >/dev/null 2>&1; then
        ACTUAL_CHECKSUM=$(shasum -a 256 "$TMP_FILE" | awk '{print $1}')
    else
        printf "${YELLOW}Warning: Neither sha256sum nor shasum found${NC}\n"
        printf "Skipping checksum verification.\n"
        rm -f "$CHECKSUMS_PATH"
        return 0
    fi

    # Compare checksums
    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
        printf "${RED}Error: Checksum verification failed!${NC}\n" >&2
        printf "Expected: $EXPECTED_CHECKSUM\n" >&2
        printf "Got:      $ACTUAL_CHECKSUM\n" >&2
        printf "\nThe downloaded binary may be corrupted or tampered with.\n" >&2
        rm -f "$TMP_FILE" "$CHECKSUMS_PATH"
        exit 1
    fi

    printf "${GREEN}✓ Checksum verified${NC}\n"
    rm -f "$CHECKSUMS_PATH"
}

# Download binary
download_binary() {
    printf "${BLUE}Downloading devos for ${OS}-${ARCH}...${NC}\n"

    TMP_FILE=$(mktemp)

    if ! curl -fsSL -o "$TMP_FILE" "$DOWNLOAD_URL"; then
        rm -f "$TMP_FILE"
        printf "${RED}Error: Failed to download binary${NC}\n" >&2
        printf "Download URL: $DOWNLOAD_URL\n" >&2
        exit 1
    fi

    # Make binary executable
    chmod +x "$TMP_FILE"
}

# Install binary
install_binary() {
    printf "${BLUE}Installing to ${INSTALL_DIR}/devos...${NC}\n"

    # Move binary to install location
    if ! mv "$TMP_FILE" "${INSTALL_DIR}/devos"; then
        rm -f "$TMP_FILE"
        printf "${RED}Error: Failed to install binary${NC}\n" >&2
        printf "You may need to run with sudo or choose a different install location.\n" >&2
        exit 1
    fi
}

# Verify installation
verify_installation() {
    if command -v devos >/dev/null 2>&1; then
        VERSION=$(devos version 2>/dev/null | head -n1 | awk '{print $NF}')
        printf "${GREEN}✓ devos ${VERSION} installed successfully!${NC}\n\n"
        printf "Run 'devos --help' to get started.\n"
    else
        printf "${YELLOW}Warning: devos was installed but is not in your PATH${NC}\n"
        printf "Add ${INSTALL_DIR} to your PATH or run: ${INSTALL_DIR}/devos\n"
    fi
}

# Main installation flow
main() {
    printf "${BLUE}╔════════════════════════════════════════╗${NC}\n"
    printf "${BLUE}║   DevOS Installation Script           ║${NC}\n"
    printf "${BLUE}║   by Effective Momentum                ║${NC}\n"
    printf "${BLUE}╚════════════════════════════════════════╝${NC}\n\n"

    detect_os
    detect_arch
    determine_install_location
    fetch_latest_release
    download_checksums
    download_binary
    verify_checksum
    install_binary
    verify_installation
}

# Run main function
main
