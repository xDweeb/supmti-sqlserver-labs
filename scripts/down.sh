#!/usr/bin/env bash
# ── down.sh ── Stop SQL Server (data preserved in volume) ───────
set -euo pipefail
cd "$(dirname "$0")/.."

echo "🛑 Stopping SQL Server..."
docker compose down
echo "✅ Stopped. Data is preserved in the 'mssql_data' volume."
