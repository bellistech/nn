#!/usr/bin/env bash
set -euo pipefail

# nn installer
# Usage: curl -fsSL https://raw.githubusercontent.com/bellistech/nn/main/install.sh | bash

REPO="bellistech/nn"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
MAN_DIR="${MAN_DIR:-$HOME/.local/share/man/man1}"
BINARY_NAME="nn"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

info()  { echo -e "${BLUE}→${RESET} $1"; }
ok()    { echo -e "${GREEN}✓${RESET} $1"; }
warn()  { echo -e "${YELLOW}!${RESET} $1"; }
error() { echo -e "${RED}✗${RESET} $1"; exit 1; }

echo ""
echo -e "${BLUE}nn${RESET} - New Note installer"
echo ""

# Check bash version
BASH_VERSION_MAJOR="${BASH_VERSION%%.*}"
if [[ "$BASH_VERSION_MAJOR" -lt 4 ]]; then
    warn "bash 4+ recommended (you have $BASH_VERSION)"
fi

# Create install directories
if [[ ! -d "$INSTALL_DIR" ]]; then
    info "Creating $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
fi

if [[ ! -d "$MAN_DIR" ]]; then
    info "Creating $MAN_DIR"
    mkdir -p "$MAN_DIR"
fi

# Download nn
info "Downloading nn..."
DOWNLOAD_URL="https://raw.githubusercontent.com/${REPO}/main/nn"

if command -v curl &>/dev/null; then
    curl -fsSL "$DOWNLOAD_URL" -o "${INSTALL_DIR}/${BINARY_NAME}"
elif command -v wget &>/dev/null; then
    wget -q "$DOWNLOAD_URL" -O "${INSTALL_DIR}/${BINARY_NAME}"
else
    error "curl or wget required"
fi

chmod +x "${INSTALL_DIR}/${BINARY_NAME}"
ok "Installed nn to ${INSTALL_DIR}/${BINARY_NAME}"

# Download man page
info "Downloading man page..."
MAN_URL="https://raw.githubusercontent.com/${REPO}/main/nn.1"

if command -v curl &>/dev/null; then
    curl -fsSL "$MAN_URL" -o "${MAN_DIR}/nn.1" 2>/dev/null || true
elif command -v wget &>/dev/null; then
    wget -q "$MAN_URL" -O "${MAN_DIR}/nn.1" 2>/dev/null || true
fi

if [[ -f "${MAN_DIR}/nn.1" ]]; then
    ok "Installed man page to ${MAN_DIR}/nn.1"
else
    warn "Man page download failed (optional)"
fi

# Check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    warn "$INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add to your shell config:"
    echo ""
    echo "  # For bash (~/.bashrc)"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "  export MANPATH=\"\$HOME/.local/share/man:\$MANPATH\""
    echo ""
    echo "  # For zsh (~/.zshrc)"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "  export MANPATH=\"\$HOME/.local/share/man:\$MANPATH\""
    echo ""
fi

# Verify installation
if command -v nn &>/dev/null || [[ -x "${INSTALL_DIR}/${BINARY_NAME}" ]]; then
    VERSION=$("${INSTALL_DIR}/${BINARY_NAME}" --version 2>/dev/null || echo "unknown")
    ok "nn ${VERSION} ready"
else
    warn "Installation may require shell restart"
fi

# Shell completions hint
echo ""
info "Optional: Add shell completions"
echo ""
echo "  # bash"
echo "  echo 'eval \"\$(nn --completions)\"' >> ~/.bashrc"
echo ""
echo "  # zsh"
echo "  echo 'eval \"\$(nn --completions)\"' >> ~/.zshrc"
echo ""

# Quick start
echo -e "${GREEN}Quick start:${RESET}"
echo "  nn              # Create today's journal"
echo "  nn -a \"hello\"   # Quick append"
echo "  nn --help       # All commands"
echo "  man nn          # Full manual"
echo ""
