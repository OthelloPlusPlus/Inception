# Inception - MariaDB
MariaDB is an open-source relational database management system (RDBMS) that originated as a fork of MySQL. It was created by the original developers of MySQL after concerns arose over the acquisition of MySQL by Oracle Corporation. MariaDB shares a similar architecture and design with MySQL but offers additional features, performance improvements, and a commitment to open-source principles. It is known for its compatibility with MySQL, making it a drop-in replacement for many MySQL applications. MariaDB is widely used for building and managing databases in various applications and industries.

# Table of Contents
- [Users](#users)
- [Databases](#databases)
- [Tables](#tables)

## Users
```mysql
-- Show existing users
SELECT User, Host, Password FROM mysql.user;
-- Create new user with set password
CREATE USER IF NOT EXISTS 'username'@'localhost' IDENTIFIED BY 'password';
-- Alter user settings
ALTER USER 'username'@'host'
    IDENTIFIED BY 'new_password'    -- Changes the password for the user.
    IDENTIFIED WITH authentication_plugin    -- Changes the authentication plugin for the user.
    IDENTIFIED WITH authentication_plugin AS 'authentication_string'    -- Changes the authentication plugin and authentication string for the user.
    REQUIRE NONE    -- Removes the requirement for SSL/TLS for the user.
    REQUIRE SSL    -- Requires SSL/TLS for the user.
    REQUIRE X509    -- Requires SSL/TLS with X.509 certificate authentication for the user.
    REQUIRE ISSUER 'issuer'    -- Requires SSL/TLS with X.509 certificate authentication and a specific issuer for the user.
    REQUIRE SUBJECT 'subject'    -- Requires SSL/TLS with X.509 certificate authentication and a specific subject for the user.
    REQUIRE CIPHER 'cipher'    -- Requires SSL/TLS with a specific cipher for the user.
    REQUIRE ISSUER '/C=country/ST=state/L=location/O=organisation/OU=department/CN=commonname/emailAddress=email@address.com'    -- Example of specifying issuer for SSL/TLS.
    ACCOUNT LOCK    -- Locks the user account, preventing login.
    ACCOUNT UNLOCK    -- Unlocks a previously locked user account.
    PASSWORD EXPIRE    -- Sets the password of the user to expire.
    PASSWORD EXPIRE INTERVAL N DAY    -- Sets the password of the user to expire after N days.
    PASSWORD EXPIRE NEVER    -- Sets the password of the user to never expire.
    MAX_QUERIES_PER_HOUR count    -- Sets the maximum number of queries the user can execute per hour.
    MAX_UPDATES_PER_HOUR count    -- Sets the maximum number of updates (inserts, deletes, updates) the user can execute per hour.
    MAX_CONNECTIONS_PER_HOUR count    -- Sets the maximum number of connections the user can make per hour.
    MAX_USER_CONNECTIONS count    -- Sets the maximum number of simultaneous connections the user can have.
    RESOURCE GROUP group_name;    -- Assigns the user to a specific resource group.

-- Adjust privileges
GRANT ALL ON *.* TO 'username'@'%';
FLUSH PRIVILEGES;
-- Delete User
DROP USER 'name'@'localhost';
```

## Databases
```mysql
-- Show existing databases
SHOW DATABASES;
-- Create new database;
CREATE DATABASE IF NOT EXISTS name;
-- Switch to database
USE name;
-- Alter database
ALTER DATABASE name
    CHARACTER SET setname    -- Changes the character set of the database and its default collation.
    COLLATE collationname    -- Changes the default collation for the database.
    DEFAULT CHARACTER SET setname    -- Sets the default character set for the database.
    DEFAULT COLLATE collationname    -- Sets the default collation for the database.
    DEFAULT ENCRYPTION [=] { 'Y' | 'N' }    -- Sets the default encryption for new tables in the database.
    DEFAULT STORAGE ENGINE storage_engine_name    -- Sets the default storage engine for the database.
    RENAME TO new_database_name    -- Renames the database.
    UPGRADE DATA DIRECTORY NAME    -- Upgrades the data directory name for the database.
    DEFAULT TABLE ENCRYPTION [=] { 'Y' | 'N' }    -- Sets the default table encryption for the database.
    UPGRADE    -- Upgrades the database to a new version.
    CONNECTION LIMIT max_connections    -- Sets the maximum number of simultaneous client connections allowed to the database.
    MAX_CONNECTIONS_PER_HOUR max_connections    -- Sets the maximum number of connections allowed per hour from a single host to the database.
    MAX_QUERIES_PER_HOUR max_queries    -- Sets the maximum number of queries allowed per hour from a single host to the database.
    MAX_UPDATES_PER_HOUR max_updates    -- Sets the maximum number of updates (inserts, deletes, updates) allowed per hour from a single host to the database.
    MAX_USER_CONNECTIONS max_connections;    -- Sets the maximum number of simultaneous connections allowed for any user account to the database.
-- Delete database
DROP DATABASE name;
```

## Tables
```mysql
-- Show existing tables in a database
SHOW TABLES;
-- Show table structure
DESCRIBE name;
SHOW COLUMNS FROM name;
-- Show table contents
SELECT * FROM name;
-- Create a new table (requires at least 1 column)
CREATE TABLE IF NOT EXISTS name    --colname datatype constraint
(
    id INT PRIMARY KEY,    -- number, used as primary key
    name VARCHAR(23) NOT NULL, -- character string, cannot be empty
    uniquename VARCHAR(42) UNIQUE    -- character string, must be unique
);
-- Rename table
RENAME TABLE oldname TO newname;
-- Alter table
ALTER TABLE name
    ADD colname datatype constraints    -- Add a new column to the table
    MODIFY colname datatype constraints    -- Modify a column in the table
    CHANGE oldcolname newcolname datatype constraints    -- Modify column name
    DROP COLUMN colname;    -- Remove column from table
-- Inject information row
INSERT INTO name (id, uniquename, name)
VALUES    (1, 'ipsum', 'Lorem'),
    (2, 'dolor', 'Lorem'),
    (3, 'sit', 'Lorem');
-- Remove information row
DELETE FROM name WHERE condition;    -- condition example: id = 2
-- Truncate table (clear rows)
TRUNCATE TABLE name;
-- Remove table
DROP TABLE name;
```
