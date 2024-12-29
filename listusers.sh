#!/bin/bash

# Prompt for GitHub username or organization
read -p "Enter the repository owner (username or organization): " REPO_OWNER

# Prompt for repository name
read -p "Enter the repository name: " REPO_NAME

# Prompt for access token securely
read -s -p "Enter your GitHub Personal Access Token: " TOKEN
echo ""

# GitHub API Endpoint
API_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/collaborators"

# Fetch and display collaborators
response=$(curl -s -H "Authorization: token $TOKEN" $API_URL)

# Check if the token is valid
if echo "$response" | jq -e .message > /dev/null 2>&1; then
    echo "Error: $(echo "$response" | jq -r .message)"
else
    echo "Collaborators with access to the repository:"
    echo "$response" | jq -r '.[] | .login'
fi
