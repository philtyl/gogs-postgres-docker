DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = 'git') THEN
            CREATE USER git WITH PASSWORD '${postgres-userpass}';
        ELSE
            ALTER USER git WITH PASSWORD '${postgres-userpass}';
        END IF;

        IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_database where datname = 'gogs') THEN
            CREATE DATABASE gogs OWNER git;
        END IF;
    END
$$;