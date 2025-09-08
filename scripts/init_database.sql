-- =============================================================
-- Create Database and Schemas
-- =============================================================
-- Script Purpose:
--     This script drops and recreates the 'datawarehouse' database,
--     then sets up three schemas: 'bronze', 'silver', and 'gold'.
--
-- WARNING:
--     Running this script will permanently delete the 'datawarehouse' database
--     if it exists. Ensure proper backups before proceeding.
-- =============================================================

-- Connect to the default 'postgres' database to manage other databases
-- Drop the 'datawarehouse' database if it exists
DO $$
BEGIN
    IF EXISTS (
        SELECT FROM pg_database WHERE datname = 'datawarehouse'
    ) THEN
        -- Terminate active connections to allow drop
        PERFORM pg_terminate_backend(pid)
        FROM pg_stat_activity
        WHERE datname = 'datawarehouse'
          AND pid <> pg_backend_pid();

        DROP DATABASE datawarehouse;
    END IF;
END $$;

-- Create the new database
CREATE DATABASE datawarehouse;

-- ⚠️ PostgreSQL does not support USE; reconnect to 'datawarehouse' manually
-- Example in psql CLI:
-- \c datawarehouse

-- After reconnecting, create schemas
-- These commands should be run inside the 'datawarehouse' session
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
