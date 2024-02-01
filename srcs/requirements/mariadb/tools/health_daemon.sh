mariadb	-h localhost --protocol tcp -e 'select 1' 2>&1 | \
	grep -qf "Can't connect" 2> /dev/null;

exit $(( ! $? ))
