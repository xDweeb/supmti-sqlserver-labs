#!/usr/bin/env bash
# ── up.sh ── Start SQL Server 2019 and run init scripts ─────────
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
    echo "📋 .env not found – copying from .env.example"
    cp .env.example .env
    echo "   ⚠️  Edit .env to set your own MSSQL_SA_PASSWORD before continuing."
fi

echo "🚀 Starting SQL Server 2019 Express..."
docker compose up -d

echo ""
echo "✅ SQL Server is running on port 1433"
echo "   Use './scripts/sql.sh' to open an interactive SQL prompt."
