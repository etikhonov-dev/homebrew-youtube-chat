#!/bin/bash
set -e

# YouTube CLI Companion Installation Script
# Supports macOS, Linux, and WSL

REPO="etikhonov-dev/youtube-chat-releases"
BINARY_NAME="youtube-chat"
INSTALL_DIR="/usr/local/bin"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored messages
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Detect OS and architecture
detect_platform() {
    local os=$(uname -s | tr '[:upper:]' '[:lower:]')
    local arch=$(uname -m)

    case "$os" in
        darwin*)
            OS="macos"
            ;;
        linux*)
            OS="linux"
            ;;
        *)
            print_error "Unsupported operating system: $os"
            exit 1
            ;;
    esac

    case "$arch" in
        x86_64|amd64)
            ARCH="x64"
            ;;
        arm64|aarch64)
            ARCH="arm64"
            ;;
        *)
            print_error "Unsupported architecture: $arch"
            exit 1
            ;;
    esac

    PLATFORM="${OS}-${ARCH}"
    print_info "Detected platform: $PLATFORM"
}

# Get latest release version
get_latest_version() {
    print_info "Fetching latest release..."
    VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

    if [ -z "$VERSION" ]; then
        print_error "Failed to fetch latest version"
        exit 1
    fi

    print_info "Latest version: $VERSION"
}

# Download and install binary
install_binary() {
    local download_url="https://github.com/${REPO}/releases/download/${VERSION}/${BINARY_NAME}-${PLATFORM}"
    local temp_file="/tmp/${BINARY_NAME}"

    print_info "Downloading from: $download_url"

    if ! curl -fsSL "$download_url" -o "$temp_file"; then
        print_error "Failed to download binary"
        print_info "You can download manually from: https://github.com/${REPO}/releases/latest"
        exit 1
    fi

    chmod +x "$temp_file"

    # Try to install to /usr/local/bin, fall back to ~/.local/bin if no permission
    if [ -w "$INSTALL_DIR" ] || sudo -n true 2>/dev/null; then
        print_info "Installing to $INSTALL_DIR (may require sudo)..."
        sudo mv "$temp_file" "$INSTALL_DIR/$BINARY_NAME"
        print_info "Successfully installed to $INSTALL_DIR/$BINARY_NAME"
    else
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"
        mv "$temp_file" "$INSTALL_DIR/$BINARY_NAME"
        print_warning "Installed to $INSTALL_DIR/$BINARY_NAME"

        # Check if directory is in PATH
        if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
            print_warning "Add $INSTALL_DIR to your PATH by adding this to your shell profile:"
            echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
        fi
    fi
}

# Verify installation
verify_installation() {
    print_info "Verifying installation..."

    if command -v $BINARY_NAME &> /dev/null; then
        print_info "Installation successful!"
        print_info "Run '$BINARY_NAME --help' to get started"
        print_info ""
        print_warning "Don't forget to set your GOOGLE_API_KEY environment variable!"
        print_info "Get your API key at: https://aistudio.google.com/app/apikey"
    else
        print_error "Installation verification failed"
        print_info "Please ensure $INSTALL_DIR is in your PATH"
        exit 1
    fi
}

# Main installation flow
main() {
    echo "YouTube CLI Companion Installer"
    echo "================================"
    echo ""

    detect_platform
    get_latest_version
    install_binary
    verify_installation
}

main