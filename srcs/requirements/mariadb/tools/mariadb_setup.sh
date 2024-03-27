#! /bin/bash

C_RESET="\x1b[0m"
C_DGRAY="\x1b[38;2;64;64;64m"

# =====================================||===================================== #
#																			   #
#								   Functions								   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

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

msg	"Running .sql configuring setting default values"
msg	"Expected error:     Access denied for user 'root'@'localhost' (using password: NO)"
envsubst < /usr/local/bin/mariadb_init.sql | mariadb -u$DB_ROOT_USER -p$DB_ROOT_PWD

if [ "$ALREADY_RUNNING" = false ]; then
	msg	"Shutting mariadb down for reboot"
	mariadbWait
	mariadb -u$DB_ROOT_USER -p$DB_ROOT_PWD -e "SHUTDOWN";
	mariadbWait
	if [ -f "/run/mysqld/mysqld.pid" ]; then
		msg "Failed to shutdown, killing instead"
		kill $(cat /run/mysqld/mysqld.pid)
	fi

	msg	"Exec command: $@"
	exec "$@"
fi
