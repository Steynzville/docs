# ThermaCore App Documentation

This repository contains the documentation for the ThermaCore App, automatically synchronized from the [steynzville/thermacoreapp](https://github.com/steynzville/thermacoreapp) repository using Mintlify.

## Features

- **Automatic Sync**: Documentation is automatically updated when commits and merged PRs occur in the thermacoreapp repository
- **Mintlify Integration**: Built with Mintlify for beautiful, interactive documentation
- **GitHub Actions**: Automated deployment and synchronization workflows
- **Live Preview**: Local development server for testing changes

## Quick Start

The Mintlify CLI is already installed and configured for this repository.

## Development

The [Mintlify CLI](https://www.npmjs.com/package/mint) is installed and configured. To preview documentation changes locally:

```bash
# Install Mintlify CLI (if not already installed)
npm i -g mint

# Start development server
mint dev
```

View your local preview at `http://localhost:3000`.

## Automatic Synchronization

This documentation is automatically synchronized from the `steynzville/thermacoreapp` repository:

- **Triggers**: Commits and merged PRs in the thermacoreapp repository
- **Paths Monitored**: `docs/**`, `README.md`, `API.md`, and other markdown files
- **Workflow**: GitHub Actions automatically sync content and deploy updates

### Manual Sync

You can manually trigger documentation synchronization:

1. Go to the **Actions** tab in this repository
2. Select "Sync Documentation from ThermacoreApp"
3. Click "Run workflow"
4. Specify the source repository and branch/commit

## Setup for ThermacoreApp Repository

To enable automatic documentation updates from the thermacoreapp repository, see the [Webhook Setup Guide](./webhooks/setup.md).

## Deployment

### Automatic Deployment

- **GitHub Actions**: Automatically deploys when changes are pushed to the main branch
- **Mintlify Integration**: Configure `MINTLIFY_API_KEY` secret for direct deployment
- **GitHub App**: Install the [Mintlify GitHub app](https://dashboard.mintlify.com/settings/organization/github-app) for seamless integration

### Manual Deployment

If configured with Mintlify API key:

```bash
mintlify deploy
```

## Configuration

### Repository Structure

- `docs.json` - Mintlify configuration file
- `.github/workflows/` - Automated deployment and sync workflows
- `webhooks/` - Integration setup guides
- Documentation content organized in folders with MDX files

### Environment Variables

- `MINTLIFY_API_KEY` - (Optional) For direct deployment to Mintlify
- `DOCS_REPO_TOKEN` - For thermacoreapp repository to trigger documentation updates

## Need help?

### Troubleshooting

- If your dev environment isn't running: Run `mint update` to ensure you have the most recent version of the CLI.
- If a page loads as a 404: Make sure you are running in a folder with a valid `docs.json`.

### Resources
- [Mintlify documentation](https://mintlify.com/docs)
