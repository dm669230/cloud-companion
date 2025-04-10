-- ✅ Step 1: Check if PostgreSQL is installed
psql --version

-- ❌ If "psql" not recognized:
-- ➤ Install PostgreSQL from https://www.postgresql.org/download/
-- ➤ After install, add PostgreSQL’s bin path (e.g., "C:\Program Files\PostgreSQL\17\bin") to your system Environment Variables > Path

-- ✅ Step 2: Log into PostgreSQL via terminal
psql -U postgres
-- If prompted for password, enter the one you set during installation
-- On success, you'll see:
-- postgres=#

-- ✅ Step 3: Create the database
CREATE DATABASE cloud_comp;

-- ✅ Step 4: Verify database creation
\l

-- ✅ Step 5: Connect to the new database
\c cloud_comp

-- ✅ Step 6: Run schema setup file to create all tables
-- Make sure your .sql file is ready (e.g., cloud_comp_schema.sql)
-- Exit psql first if needed by typing:
\q

-- Then from your terminal:
psql -U postgres -d cloud_comp -f path/to/cloud_comp_schema.sql
