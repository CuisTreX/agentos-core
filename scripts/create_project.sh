#!/bin/bash
# AgentOS Project Creator
# Usage: bash create_project.sh "project-name"
# Creates a numbered AgentOS project directory from the project template.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$WORKSPACE_ROOT/templates/project_template"

if [ $# -eq 0 ]; then
    echo "Error: Project name is required."
    echo "Usage: bash create_project.sh \"project-name\""
    echo "Example: bash create_project.sh \"user-service\""
    exit 1
fi

PROJECT_NAME="$1"

# Validate project name (lowercase, hyphens, alphanumeric)
if ! [[ "$PROJECT_NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
    echo "Error: Project name must be lowercase, start with a letter, and contain only hyphens and alphanumeric characters."
    echo "Examples: user-service, api-gateway, cli-tool"
    exit 1
fi

# Find the next project number
NEXT_NUM=1
for DIR in "$WORKSPACE_ROOT"/Project_*_*/; do
    if [ -d "$DIR" ]; then
        BASENAME=$(basename "$DIR")
        NUM=${BASENAME#Project_}
        NUM=${NUM%%_*}
        # Strip leading zeroes for arithmetic
        NUM=$((10#$NUM))
        if [ "$NUM" -ge "$NEXT_NUM" ]; then
            NEXT_NUM=$((NUM + 1))
        fi
    fi
done

# Format project number (zero-padded)
PADDED_NUM=$(printf "%02d" "$NEXT_NUM")

PROJECT_DIR="$WORKSPACE_ROOT/Project_${PADDED_NUM}_${PROJECT_NAME}"

if [ -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory already exists: $PROJECT_DIR"
    exit 1
fi

if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Template directory not found: $TEMPLATE_DIR"
    echo "Make sure this script is in the AgentOS/scripts/ directory."
    exit 1
fi

# Create project directory and copy template
mkdir -p "$PROJECT_DIR"
cp -r "$TEMPLATE_DIR/"* "$PROJECT_DIR/"

echo "Project created: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. Edit PROJECT_MANIFEST.md — fill in project name, description, tech stack"
echo "  2. Edit PROJECT_MEMORY.md — document initial architecture and constraints"
echo "  3. Add project to 00_WORKSPACE_MANIFEST.md under Projects"
echo "  4. Create initial DECISION_LOG.md entry"
echo "  5. Start your first AI session"
