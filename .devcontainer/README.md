# Dev Container Configuration

This directory contains the development container configuration for GitHub Agentic Workflows.

## What's Included

### Base Environment
- Ubuntu-based container
- Git and curl pre-installed

### Development Tools
- **GitHub CLI (gh)**: For interacting with GitHub and running gh-aw commands
- **Node.js (LTS)**: Required for various workflow tools and dependencies
- **Docker-in-Docker**: Enables running Docker commands within the container

### VS Code Extensions
- **GitHub Copilot**: AI-powered code completion
- **GitHub Copilot Chat**: Conversational AI assistance
- **YAML Support**: Syntax highlighting and validation for YAML files
- **Markdown Linting**: Ensures markdown files follow best practices
- **GitHub Actions**: Support for GitHub Actions workflow files

### Post-Creation Setup
The container automatically:
1. Installs the gh-aw CLI extension
2. Configures GitHub Copilot with agentic workflow instructions
3. Verifies all tool installations

## Using the Dev Container

### Prerequisites
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (or Docker Engine)

### Opening the Dev Container

1. Open this repository in VS Code
2. When prompted, click "Reopen in Container" (or press F1 and select "Dev Containers: Reopen in Container")
3. Wait for the container to build and start (first time may take a few minutes)
4. Once ready, you'll be inside the dev container with all tools pre-installed

### First-Time Setup

After the container is created, authenticate with GitHub:

```bash
gh auth login
```

Follow the prompts to authenticate. This is required to use the gh-aw CLI extension.

### Verifying Installation

Check that everything is installed:

```bash
# Check GitHub CLI
gh --version

# Check gh-aw extension
gh aw version

# Check Node.js
node --version

# Check npm
npm --version
```

## Using GitHub Agentic Workflows

### With GitHub Copilot Chat

1. Open GitHub Copilot Chat in VS Code
2. Type `/agent` and select `agentic-workflows`
3. Ask questions or request workflow creation/updates

### With gh-aw CLI

```bash
# List available commands
gh aw --help

# Create a new workflow
gh aw new my-workflow

# Add a workflow from the catalog
gh aw add <workflow-name>

# Compile workflows
gh aw compile
```

## Customization

### Adding More VS Code Extensions

Edit `.devcontainer/devcontainer.json` and add extension IDs to the `extensions` array:

```json
"extensions": [
  "GitHub.copilot",
  "your-publisher.extension-name"
]
```

### Adding More Tools

Edit `.devcontainer/devcontainer.json` and add features:

```json
"features": {
  "ghcr.io/devcontainers/features/python:1": {
    "version": "3.11"
  }
}
```

### Modifying Post-Creation Setup

Edit `.devcontainer/setup.sh` to add additional setup commands that should run after the container is created.

## Troubleshooting

### gh-aw extension not found

If `gh aw` commands don't work:

```bash
# Reinstall the extension
curl -fsSL https://raw.githubusercontent.com/github/gh-aw/refs/heads/main/install-gh-aw.sh | bash

# Verify installation
gh extension list
```

### GitHub authentication required

Most gh-aw commands require authentication:

```bash
gh auth login
```

### Container rebuild needed

If you make changes to the devcontainer configuration:

1. Press F1 in VS Code
2. Select "Dev Containers: Rebuild Container"
3. Wait for the rebuild to complete

## Resources

- [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [GitHub Agentic Workflows](https://github.com/github/gh-aw)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
