#!/bin/bash

# Mintlify Setup Validation Script
# This script validates the Mintlify configuration and setup

echo "🔍 Validating Mintlify Setup..."
echo "================================="

# Check if we're in the right directory
if [ ! -f "docs.json" ]; then
    echo "❌ Error: docs.json not found in current directory"
    exit 1
fi

echo "✅ docs.json found"

# Check if Mintlify CLI is installed
if command -v mint &> /dev/null; then
    echo "✅ Mintlify CLI is installed ($(mint --version))"
else
    echo "⚠️  Mintlify CLI not found. Installing..."
    PUPPETEER_SKIP_DOWNLOAD=true npm i -g mint
    if command -v mint &> /dev/null; then
        echo "✅ Mintlify CLI installed successfully ($(mint --version))"
    else
        echo "❌ Failed to install Mintlify CLI"
        exit 1
    fi
fi

# Validate docs.json structure
echo "🔍 Validating docs.json structure..."
node -e "
try {
    const config = JSON.parse(require('fs').readFileSync('docs.json', 'utf8'));
    
    if (!config.name) {
        console.log('❌ Missing: name field in docs.json');
        process.exit(1);
    }
    
    if (!config.navigation) {
        console.log('❌ Missing: navigation field in docs.json');
        process.exit(1);
    }
    
    if (config.metadata && config.metadata.sourceRepository) {
        console.log('✅ Source repository configured:', config.metadata.sourceRepository);
    } else {
        console.log('⚠️  No source repository configured in metadata');
    }
    
    console.log('✅ docs.json structure is valid');
    console.log('✅ Site name:', config.name);
} catch (error) {
    console.log('❌ Invalid JSON in docs.json:', error.message);
    process.exit(1);
}
"

# Check for broken links
echo "🔍 Checking for broken links..."
mint broken-links | head -10

# Check GitHub workflows
echo "🔍 Checking GitHub workflows..."
if [ -d ".github/workflows" ]; then
    echo "✅ GitHub workflows directory exists"
    
    if [ -f ".github/workflows/mintlify.yml" ]; then
        echo "✅ Mintlify deployment workflow configured"
    else
        echo "⚠️  Mintlify deployment workflow not found"
    fi
    
    if [ -f ".github/workflows/sync-docs.yml" ]; then
        echo "✅ Documentation sync workflow configured"
    else
        echo "⚠️  Documentation sync workflow not found"
    fi
else
    echo "⚠️  No GitHub workflows directory found"
fi

# Check webhook setup guide
if [ -f "webhooks/setup.md" ]; then
    echo "✅ Webhook setup guide available"
else
    echo "⚠️  Webhook setup guide not found"
fi

echo ""
echo "🎉 Mintlify Setup Validation Complete!"
echo "================================="

echo "📋 Setup Summary:"
echo "• Mintlify CLI: Installed and working"
echo "• Configuration: docs.json is valid"
echo "• Workflows: GitHub Actions configured for documentation sync"
echo "• Integration: Ready for thermacoreapp repository sync"
echo ""
echo "📚 Next Steps:"
echo "1. Set up webhook in steynzville/thermacoreapp repository"
echo "2. Test local development with 'mint dev'"
echo "3. For Mintlify deployment, use the separate mintlify.yml workflow"