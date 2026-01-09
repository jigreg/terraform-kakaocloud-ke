#!/bin/bash
# ==============================================================================
# Generate Terraform Documentation
# ==============================================================================
# Runs terraform-docs on all module directories
#
# Usage:
#   ./scripts/generate-docs.sh
#   ./scripts/generate-docs.sh --check  # Check if docs are up-to-date

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if terraform-docs is installed
if ! command -v terraform-docs &> /dev/null; then
    echo "terraform-docs is not installed. Install with:"
    echo "  brew install terraform-docs"
    exit 1
fi

# Directories to generate docs for
DIRS=(
    "$ROOT_DIR"
    "$ROOT_DIR/modules/cluster"
    "$ROOT_DIR/modules/node-pool"
    "$ROOT_DIR/modules/scheduled-scaling"
    "$ROOT_DIR/examples/simple"
    "$ROOT_DIR/examples/multiple-node-pools"
    "$ROOT_DIR/examples/auto-scaling"
    "$ROOT_DIR/examples/scheduled-scaling"
)

# Generate docs for each directory
for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ] && ls "$dir"/*.tf &> /dev/null; then
        echo -e "${GREEN}[DOCS]${NC} Generating: $dir"
        cd "$dir"
        terraform-docs markdown table --output-file README.md --output-mode inject .
    fi
done

echo -e "${GREEN}Done!${NC} Documentation generated for ${#DIRS[@]} directories."
