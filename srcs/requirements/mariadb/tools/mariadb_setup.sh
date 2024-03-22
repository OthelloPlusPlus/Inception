#! /bin/bash

C_RESET="\x1b[0m"
C_DGRAY="\x1b[38;2;64;64;64m"

# For Connection info:
# apt-get install -y tcpdump
# tcpdump -i <interface> -A -s 0 'tcp port 80'

# =====================================||===================================== #
#																			   #
#								   Functions								   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

function	mariadbCMD()
{
	mariadb	-u$DB_ROOT_USER \
			-p$DB_ROOT_PWD \
			-e "$1"
}

function	mariadbWait()
{
	sleep 1
}

function	msg()
{
	echo -e	"$C_DGRAY""$1""$C_RESET"
}

# =====================================||===================================== #
#																			   #
#									 Script									   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

if ps aux | grep -v grep | grep -v setup | grep -wq mariadbd ; then
	msg "MariaDB deamon is already running."
	ALREADY_RUNNING=true
else
	msg	"Starting mariadb"
	service mariadb start
	ALREADY_RUNNING=false
fi

msg	"Creating database $DB_NAME"
mariadbCMD	"CREATE DATABASE IF NOT EXISTS $DB_NAME;"

msg	"Creating $DB_ROLE role for $DB_NAME access"
mariadbCMD	"CREATE ROLE IF NOT EXISTS $DB_ROLE;\
			GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX ON $DB_NAME.* TO $DB_ROLE;"

msg	"Setting $DB_ROOT_USER@locahost"
msg	"Expected error:     Access denied for user 'root'@'localhost' (using password: NO)"
mariadbCMD	"ALTER USER '$DB_ROOT_USER'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';\
			GRANT ALL ON *.* TO '$DB_ROOT_USER'@'localhost';"

msg	"Setting $DB_USER@%;"
mariadbCMD	"CREATE USER IF NOT EXISTS '$DB_USER'@'%';\
			ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';\
			GRANT $DB_ROLE TO '$DB_USER'@'%';\
			SET DEFAULT ROLE $DB_ROLE FOR '$DB_USER'@'%';"

msg	"Flushing privileges"
mariadbCMD	"FLUSH PRIVILEGES;"

if [ "$ALREADY_RUNNING" = false ]; then
	msg	"Shutting mariadb down for reboot"
	mariadbWait
	mariadbCMD	"SHUTDOWN;"
	mariadbWait
	if [ -f "/run/mysqld/mysqld.pid" ]; then
		msg "Failed to shutdown, killing instead"
		kill $(cat /run/mysqld/mysqld.pid)
	fi

	msg	"Exec command: $@"
	exec "$@"
fi
