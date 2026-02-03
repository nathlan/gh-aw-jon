# gh-aw-jon

A repository configured for GitHub Agentic Workflows, enabling AI-powered workflow authoring and management.

## Getting Started

### Option 1: Dev Container (Recommended)

The easiest way to get started is using the pre-configured dev container that includes all necessary tools and extensions:

1. Install [Visual Studio Code](https://code.visualstudio.com/)
2. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
4. Open this repository in VS Code
5. Click "Reopen in Container" when prompted (or press F1 → "Dev Containers: Reopen in Container")

The dev container includes:
- GitHub CLI with gh-aw extension pre-installed
- GitHub Copilot and Copilot Chat
- Node.js, Docker, and all development dependencies
- Pre-configured VS Code settings for agentic workflows

See [`.devcontainer/README.md`](.devcontainer/README.md) for more details.

### Option 2: Local Setup

If you prefer to work locally without a dev container:

1. Install [GitHub CLI](https://cli.github.com/)
2. Install the gh-aw extension:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/github/gh-aw/refs/heads/main/install-gh-aw.sh | bash
   ```
3. Authenticate with GitHub:
   ```bash
   gh auth login
   ```

## Using GitHub Agentic Workflows

### With GitHub Copilot Chat

1. Open Copilot Chat in VS Code
2. Type `/agent` and select `agentic-workflows`
3. Request workflow creation, updates, or debugging assistance

### With gh-aw CLI

```bash
# Create a new workflow
gh aw new my-workflow

# Add a workflow from the catalog
gh aw add <workflow-name>

# Compile workflows
gh aw compile

# Get help
gh aw --help
```

## Repository Structure

```
.
├── .devcontainer/          # Dev container configuration
├── .github/
│   ├── agents/            # AI agent definitions
│   ├── aw/                # Agentic workflow documentation and prompts
│   └── workflows/         # GitHub Actions workflows
└── .vscode/               # VS Code settings and MCP configuration
```

## Documentation

- [GitHub Agentic Workflows Guide](.github/aw/github-agentic-workflows.md) - Comprehensive documentation
- [Dev Container Setup](.devcontainer/README.md) - Dev container details
- [GitHub Agentic Workflows Repository](https://github.com/github/gh-aw) - Official gh-aw repo

## Resources

- [GitHub Agentic Workflows Documentation](https://github.com/github/gh-aw)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
