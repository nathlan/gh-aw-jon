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

#### For Windows (including WSL)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop) with WSL2 backend enabled
  - **OR** Docker Engine installed directly in WSL2

**WSL Setup:** If you're using WSL2, you have two options:
1. **Docker Desktop (Recommended)**: Install Docker Desktop for Windows with WSL2 integration enabled
2. **Docker in WSL**: Install Docker Engine directly in your WSL2 distribution

To use this dev container in WSL:
1. Make sure Docker is running in WSL (`docker ps` should work)
2. Open the repository in WSL using VS Code:
   - From WSL terminal: `code .` in the repository directory
   - Or from Windows: Click the WSL indicator in VS Code's bottom-left corner
3. The dev container will use the Docker engine running in WSL

#### For macOS/Linux
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

### WSL-Specific Issues

#### Docker not found in WSL
If you see "docker: command not found" when trying to use the dev container:

1. **With Docker Desktop**: Ensure WSL2 integration is enabled:
   - Open Docker Desktop
   - Go to Settings → Resources → WSL Integration
   - Enable integration with your WSL distribution
   - Restart Docker Desktop

2. **With Docker Engine in WSL**: Ensure Docker service is running:
   ```bash
   # Check if Docker is running
   sudo service docker status
   
   # Start Docker if needed
   sudo service docker start
   ```

#### VS Code not detecting WSL
If VS Code isn't opening in WSL:

1. Install the [Remote - WSL extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
2. From WSL terminal, navigate to the repository and run: `code .`
3. Or in VS Code, click the green icon in the bottom-left and select "Connect to WSL"

#### Slow performance in WSL
For best performance, ensure:
- Repository is cloned in the WSL filesystem (e.g., `~/projects/`), not in `/mnt/c/`
- Using WSL2 (not WSL1): `wsl -l -v` should show version 2
- Docker Desktop is using WSL2 backend (Settings → General → "Use the WSL 2 based engine")

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
