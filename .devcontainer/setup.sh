#!/bin/bash
set -e

echo "======================================"
echo "Setting up GitHub Agentic Workflows development environment..."
echo "======================================"

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo "⚠ GitHub CLI (gh) is not installed. The devcontainer features should install it."
    echo "  If this error persists, check the devcontainer configuration."
    exit 1
fi

# Install gh-aw CLI extension
echo "Installing gh-aw CLI extension..."
if ! gh extension list | grep -q "gh-aw"; then
    curl -fsSL https://raw.githubusercontent.com/github/gh-aw/refs/heads/main/install-gh-aw.sh | bash
    echo "✓ gh-aw CLI extension installed"
else
    echo "✓ gh-aw CLI extension already installed"
fi

# Verify installation
echo ""
echo "Verifying installation..."
if command -v gh &> /dev/null; then
    echo "✓ GitHub CLI (gh) version: $(gh --version | head -1)"
fi

if command -v node &> /dev/null; then
    echo "✓ Node.js version: $(node --version)"
fi

if command -v npm &> /dev/null; then
    echo "✓ npm version: $(npm --version)"
fi

# Check if gh-aw is installed
if gh extension list | grep -q "gh-aw"; then
    echo "✓ gh-aw extension installed"
    gh aw version 2>/dev/null || echo "  Note: Run 'gh auth login' to authenticate before using gh-aw"
else
    echo "⚠ gh-aw extension installation may have failed"
fi

echo ""
echo "======================================"
echo "Setup complete! You can now:"
echo "  - Use GitHub Copilot Chat with '/agent' command"
echo "  - Run 'gh aw' commands (after authenticating with 'gh auth login')"
echo "  - Create and manage agentic workflows"
echo "======================================"
