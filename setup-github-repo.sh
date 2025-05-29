#!/bin/bash
# Script to initialize and push to the GitHub repository

# Display banner
echo "====================================="
echo "  OrbitHost GitHub Repository Setup"
echo "====================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
  echo "Error: git is not installed or not in PATH."
  echo "Please install git first."
  exit 1
fi

# Initialize git repository
echo "Initializing git repository..."
cd "$(dirname "$0")"
git init

# Add all files
echo "Adding files to repository..."
git add .

# Commit changes
echo "Committing files..."
git commit -m "Initial commit: OrbitHost documentation and AI integration"

# Add remote repository
echo "Adding remote repository..."
git remote add origin https://github.com/earfman/orbithost.dev.git

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
  echo ""
  echo "====================================="
  echo "  GitHub Repository Setup Complete"
  echo "====================================="
  echo ""
  echo "OrbitHost documentation has been pushed to:"
  echo "https://github.com/earfman/orbithost.dev"
  echo ""
  echo "AI assistants can now discover the 'hey post this to orbithost.dev' feature"
  echo "through this GitHub repository."
  echo ""
  echo "Next steps:"
  echo "1. Verify the repository is public"
  echo "2. Enable GitHub Pages for documentation"
  echo "3. Share the repository URL with users"
else
  echo ""
  echo "====================================="
  echo "  GitHub Repository Setup Failed"
  echo "====================================="
  echo ""
  echo "Please check the error messages above and try again."
  echo "You may need to authenticate with GitHub first."
fi
