#!/usr/bin/env bash
# =============================================================================
# deploy-infra.sh
# StartTech Infrastructure deployment script
#
# Usage:
#   ./scripts/deploy-infra.sh init
#   ./scripts/deploy-infra.sh plan
#   ./scripts/deploy-infra.sh apply
#   ./scripts/deploy-infra.sh destroy
# =============================================================================

set -euo pipefail

# ─── Directories ──────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TF_DIR="$(cd "$SCRIPT_DIR/../terraform" && pwd)"
LOG_FILE="$ROOT_DIR/deploy-$(date +%Y%m%d-%H%M%S).log"

# ─── Config ───────────────────────────────────────────────────────────────────
AWS_REGION="${AWS_REGION:-eu-west-3}"
CLUSTER_NAME="${CLUSTER_NAME:-starttech-cluster}"