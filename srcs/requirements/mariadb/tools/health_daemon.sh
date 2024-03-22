#! /bin/bash

which mariadb &> /dev/null | exit $?;

mariadb -u$DB_USER -p$DB_PASSWORD -e "USE $DB_NAME;" &> /dev/null || exit $?;

mariadb -u$DB_ROOT_USER -p$DB_ROOT_PWD -e "USE $DB_NAME;" &> /dev/null || exit $?;

exit 0;
