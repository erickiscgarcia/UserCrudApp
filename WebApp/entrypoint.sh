#!/bin/bash
set -e

echo "⏳ Waiting for SQL Server to be available..."

until /opt/mssql-tools/bin/sqlcmd -S tcp:db,1433 -U sa -P StrongPassword123! -Q "SELECT 1"
do
  echo "⏳ Still waiting for SQL Server..."
  sleep 3
done

echo "✅ SQL Server is ready. Applying migrations..."

dotnet ef database update --project ./src/WebApp/WebApp.csproj --startup-project ./src/WebApp/WebApp.csproj --verbose || {
  echo "❌ Failed to apply migrations"
  exit 1
}

echo "🚀 Starting application..."
exec dotnet WebApp.dll --urls=http://0.0.0.0:5000
