mariadb -u$DB_ROOT_USER -p$DB_ROOT_PWD < script.sql

CREATE DATABASE IF NOT EXISTS $DB_NAME;

CREATE ROLE IF NOT EXISTS $DB_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX ON $DB_NAME.* TO $DB_ROLE;

ALTER USER '$DB_ROOT_USER'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
GRANT ALL ON *.* TO '$DB_ROOT_USER'@'localhost';

CREATE USER IF NOT EXISTS '$DB_USER'@'%';
ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT $DB_ROLE TO '$DB_USER'@'%';
SET DEFAULT ROLE $DB_ROLE FOR '$DB_USER'@'%';

FLUSH PRIVILEGES;
