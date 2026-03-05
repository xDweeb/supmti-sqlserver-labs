#!/usr/bin/env bash
# ── reset.sh ── Full reset: stop, delete volume, restart ────────
set -euo pipefail
cd "$(dirname "$0")/.."

echo "⚠️  This will DELETE all data and reinitialize the database."
echo ""

echo "🛑 Stopping containers..."
docker compose down

echo "🗑️  Removing data volume..."
docker volume rm mssql_data 2>/dev/null || true

echo "🚀 Starting fresh..."
./scripts/up.sh
