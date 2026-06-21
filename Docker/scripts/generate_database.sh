#!/bin/bash

source ./Docker/scripts/env_functions.sh

if [ "$DOCKER_ENV" == "true" ]; then
    export_env_vars
fi

# Set default DATABASE_PROVIDER if not set
DATABASE_PROVIDER_DEFAULT=${DATABASE_PROVIDER:-postgresql}

if [ "$DATABASE_PROVIDER_DEFAULT" == "postgresql" ] || [ "$DATABASE_PROVIDER_DEFAULT" == "mysql" ] || [ "$DATABASE_PROVIDER_DEFAULT" == "psql_bouncer" ]; then
    echo "Generating Prisma client for $DATABASE_PROVIDER_DEFAULT"
    # Run prisma generate (does not require DB connection)
    npm run db:generate || echo "Warning: Prisma generate had issues, continuing..."
    echo "Prisma client generation completed"
else
    echo "Warning: Unknown database provider $DATABASE_PROVIDER_DEFAULT, skipping Prisma generation"
fi
