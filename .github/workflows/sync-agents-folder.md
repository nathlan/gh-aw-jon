---
name: Sync agents folder
description: Sync /agents from nathlan/.github-private@main into this repository.
on:
  schedule:
    - cron: "0 15 * * *"
  workflow_dispatch: {}
permissions:
  contents: read
  actions: read
  issues: read
  pull-requests: read
env:
  SYNC_REPO_TOKEN: ${{ secrets.SYNC_REPO_TOKEN }}
post-steps:
  - name: Fix gh-aw log permissions
    run: sudo chmod -R a+r /tmp/gh-aw/mcp-logs /tmp/gh-aw/sandbox || true
network:
  allowed:
    - "github.com"
safe-outputs:
  create-pull-request:
    title-prefix: "[sync] "
    labels: [automation]
---

# Sync agents folder

Sync the /agents folder from nathlan/.github-private@main into /agents in this repository. This mirrors the remote folder (including deletions) and opens a pull request with the changes.

## Steps

1) Use bash to clone nathlan/.github-private@main with sparse-checkout for the agents folder.
2) Mirror the remote /agents folder into ./agents (including deletions).
3) Summarize the changes and let the safe output job create the pull request.

Use this clone command (requires the SYNC_REPO_TOKEN secret):

  git clone --depth 1 --filter=blob:none --sparse "https://x-access-token:${SYNC_REPO_TOKEN}@github.com/nathlan/.github-private.git" <tmp>

Then:

  cd <tmp>
  git sparse-checkout set agents
  rsync -a --delete "<tmp>/agents/" "$GITHUB_WORKSPACE/agents/"
