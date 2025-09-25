# Webhook Setup for ThermacoreApp Integration

This directory contains configuration and scripts for setting up automatic documentation synchronization between the `steynzville/thermacoreapp` repository and this documentation site.

## Setup Instructions

### 1. Configure GitHub Secrets

In the `Steynzville/docs` repository, add the following secrets:

- `GITHUB_TOKEN`: Already available, used for accessing the thermacoreapp repository

Note: The sync workflow only synchronizes documentation and does not deploy to Mintlify. For Mintlify deployment, use the separate `mintlify.yml` workflow which requires the `MINTLIFY_API_KEY` secret.

### 2. Add Webhook to ThermacoreApp Repository

Add the following GitHub Action workflow to the `steynzville/thermacoreapp` repository at `.github/workflows/update-docs.yml`:

```yaml
name: Update Documentation

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'
      - 'README.md'
      - 'API.md'
      - '*.md'
  pull_request:
    branches: [main]
    types: [closed]
    paths:
      - 'docs/**'
      - 'README.md' 
      - 'API.md'
      - '*.md'

jobs:
  notify-docs-repo:
    runs-on: ubuntu-latest
    if: github.event_name == 'push' || (github.event.pull_request.merged == true)
    steps:
      - name: Trigger docs synchronization
        uses: peter-evans/repository-dispatch@v3
        with:
          token: ${{ secrets.DOCS_REPO_TOKEN }}
          repository: Steynzville/docs
          event-type: sync-docs
          client-payload: |
            {
              "repository": "${{ github.repository }}",
              "ref": "${{ github.ref }}",
              "sha": "${{ github.sha }}",
              "pusher": "${{ github.actor }}"
            }
```

### 3. Configure ThermacoreApp Repository Secrets

In the `steynzville/thermacoreapp` repository, add:

- `DOCS_REPO_TOKEN`: A GitHub Personal Access Token with `repo` permissions to trigger workflows in the docs repository

### 4. Manual Sync

You can also manually trigger documentation synchronization by:

1. Going to the Actions tab in this repository
2. Selecting "Sync Documentation from ThermacoreApp"
3. Clicking "Run workflow"
4. Specifying the source repository and branch/commit

## How It Works

1. When code is pushed to the `thermacoreapp` repository (especially documentation-related files), it triggers the webhook
2. The webhook sends a `repository_dispatch` event to this docs repository
3. The `sync-docs.yml` workflow runs and:
   - Checks out both repositories
   - Extracts documentation from the source repository
   - Updates the docs configuration
   - Commits any changes
   - Pushes the updated documentation to the docs repository

## File Structure

- `.github/workflows/mintlify.yml` - Main deployment workflow
- `.github/workflows/sync-docs.yml` - Documentation synchronization workflow
- `webhooks/setup.md` - This setup guide