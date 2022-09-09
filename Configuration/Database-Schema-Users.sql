/*
--Install and edit the following file to enable remote access to the pgAdmin tool:
Edit: pg_hba.conf
edit C:\Program Files\PostgreSQL\14\data\pg_hba.conf
Append the line host all all 0.0.0.0/0 md5
*/
--PSQL

\c postgres


DROP ROLE IF EXISTS "admin-user";

CREATE ROLE "admin-user" WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
 PASSWORD 'postgres';
 
DROP ROLE IF EXISTS "base-user";

CREATE ROLE "base-user" WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
 PASSWORD 'postgres';

DROP DATABASE IF EXISTS pegadb;

CREATE DATABASE pegadb
    WITH
    OWNER = "admin-user"
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United Kingdom.1252'
    LC_CTYPE = 'English_United Kingdom.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\c pegadb 


DROP SCHEMA IF EXISTS data ;
DROP SCHEMA IF EXISTS rules ;


CREATE SCHEMA IF NOT EXISTS data AUTHORIZATION "base-user";
CREATE SCHEMA IF NOT EXISTS rules AUTHORIZATION "base-user";

ALTER DEFAULT PRIVILEGES FOR USER "admin-user" IN SCHEMA data
GRANT ALL ON TABLES TO "base-user";

ALTER DEFAULT PRIVILEGES FOR USER "admin-user" IN SCHEMA rules
GRANT ALL ON TABLES TO "base-user";

ALTER DEFAULT PRIVILEGES IN SCHEMA data GRANT EXECUTE ON FUNCTIONS TO "admin-user";
ALTER DEFAULT PRIVILEGES IN SCHEMA data GRANT EXECUTE ON FUNCTIONS TO "base-user";
ALTER DEFAULT PRIVILEGES IN SCHEMA rules GRANT EXECUTE ON FUNCTIONS TO "admin-user";
ALTER DEFAULT PRIVILEGES IN SCHEMA rules GRANT EXECUTE ON FUNCTIONS TO "base-user";
	
--Optional: Installing PL/Java for Java user-defined functions
--Optional: Creating the sqlj schema for importing Java user-defined functions
