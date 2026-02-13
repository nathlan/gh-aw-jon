---
name: Sync /sync and /target-folder
description: Sync /sync and /target-folder from nathlan/source-repo@main into this repository.
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

# Sync /sync and /target-folder

Sync the /sync and /target-folder folders from nathlan/source-repo@main into /sync and /target-folder in this repository. This merges upstream files into the local folders (no deletions of local-only files) and opens a pull request with the changes.

## Steps

1) Use bash to clone nathlan/source-repo@main with sparse-checkout for the /sync and /target-folder folders using the GH app token (in `GH_TOKEN`).
2) Merge the remote /sync folder into ./sync and /target-folder into ./target-folder (do not delete local-only files).
3) Summarize the changes and let the safe output job create the pull request.

Use this clone command (requires `GH_TOKEN`):

  git clone --depth 1 --filter=blob:none --sparse "https://x-access-token:${GH_TOKEN}@github.com/nathlan/source-repo.git" <tmp>

Then:

  cd <tmp>
  git sparse-checkout set sync target-folder
  rsync -a "<tmp>/sync/" "$GITHUB_WORKSPACE/sync/"
  rsync -a "<tmp>/target-folder/" "$GITHUB_WORKSPACE/target-folder/"
