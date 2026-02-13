---
name: Sync all folders from source-repo
description: Sync all folders from nathlan/source-repo@main into this repository, excluding important repo files.
on:
  schedule: daily
permissions: read-all
steps:
  - name: Generate a token
    id: generate-token
    uses: actions/create-github-app-token@v2
    with:
      app-id: ${{ vars.SOURCE_REPO_SYNC_APP_ID }}
      private-key: ${{ secrets.SOURCE_REPO_SYNC_APP_PRIVATE_KEY }}
      owner: nathlan
      repositories: source-repo
  - name: Export GH_TOKEN
    env:
      GH_TOKEN: ${{ steps.generate-token.outputs.token }}
    run: echo "GH_TOKEN=$GH_TOKEN" >> $GITHUB_ENV
network:
  allowed:
    - "github.com"
safe-outputs:
  create-pull-request:
    title-prefix: "[source-repo-sync] "
    labels: [automation]
    draft: false
---

# Sync all folders from source-repo

Sync **all folders** from nathlan/source-repo@main into this repository, excluding important repo-level files. This merges upstream directories into local directories (no deletions of local-only files) and opens a pull request with the changes.

## Exclusions

Do **NOT** sync any of these from the source repo:
- `.git/`, `.github/` — git internals and workflow configs
- `README.md`, `LICENSE`, `CHANGELOG.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md` — repo-level docs
- `.gitignore`, `.gitattributes` — git config files
- `.env`, `.env.*` — environment/secret files

Only **directories** (folders) from the source repo root should be synced.

## Steps

1) Use bash to do a full shallow clone of nathlan/source-repo@main using the GH app token (in `GH_TOKEN`).
2) Iterate over all top-level **directories** in the cloned repo and rsync each one into `$GITHUB_WORKSPACE`, skipping `.git/` and `.github/`.
3) Check `git status` for changes. If there are changes, use the `create_pull_request` safe output tool to open a PR. Do **NOT** try to `git push` yourself — the safe-outputs job handles pushing and PR creation automatically.

**Important**: The `GH_TOKEN` env var is ONLY for cloning the private source repo. Do NOT use it to push or set the remote URL. Do NOT run `git push` at all. Just commit your changes locally and call the `create_pull_request` tool.

Use this clone command (requires `GH_TOKEN`):

  git clone --depth 1 "https://x-access-token:${GH_TOKEN}@github.com/nathlan/source-repo.git" /tmp/source-repo

Then sync all folders, excluding .git and .github:

  cd /tmp/source-repo
  for dir in */; do
    case "$dir" in
      .git/|.github/) continue ;;
    esac
    rsync -a "/tmp/source-repo/$dir" "$GITHUB_WORKSPACE/$dir"
  done
