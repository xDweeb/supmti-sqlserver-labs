#!/usr/bin/env bash
# ── sql.sh ── Interactive sqlcmd inside the running container ────
# Usage:
#   ./scripts/sql.sh                          # interactive prompt
#   ./scripts/sql.sh -i /sql/99_drop_all.sql  # run a script file
set -euo pipefail
cd "$(dirname "$0")/.."

# Load password from .env
if [ -f .env ]; then
    source <(grep -E '^MSSQL_SA_PASSWORD=' .env)
fi

if [ -z "${MSSQL_SA_PASSWORD:-}" ]; then
    echo "❌ MSSQL_SA_PASSWORD not set. Check your .env file."
    exit 1
fi

echo "🔌 Connecting to SQL Server (Ctrl+C to exit)..."
docker exec -it sqlserver /opt/mssql-tools18/bin/sqlcmd \
    -S localhost -U sa -P "${MSSQL_SA_PASSWORD}" -C \
    -d Biblio \
    "$@"
