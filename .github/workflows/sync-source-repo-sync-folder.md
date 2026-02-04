---
name: Sync /sync folder
description: Sync /sync from nathlan/source-repo@main into this repository.
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
    title-prefix: "[sync] "
    labels: [automation]
---

# Sync /sync folder

Sync the /sync folder from nathlan/source-repo@main into /sync in this repository. This mirrors the remote folder (including deletions) and opens a pull request with the changes.

## Steps

1) Use bash to clone nathlan/source-repo@main with sparse-checkout for the /sync folder using the GH app token (in `GH_TOKEN`).
2) Mirror the remote /sync folder into ./sync (including deletions).
3) Summarize the changes and let the safe output job create the pull request.

Use this clone command (requires `GH_TOKEN`):

  git clone --depth 1 --filter=blob:none --sparse "https://x-access-token:${GH_TOKEN}@github.com/nathlan/source-repo.git" <tmp>

Then:

  cd <tmp>
  git sparse-checkout set sync
  rsync -a --delete "<tmp>/sync/" "$GITHUB_WORKSPACE/sync/"
