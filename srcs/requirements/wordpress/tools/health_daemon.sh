
pgrep -x "php-fpm7.4" &> /dev/null || exit $?;

mariadb -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "USE $DB_NAME;" &> /dev/null || exit $?;

if which wp-cli &> /dev/null; then
	echo	"wp-cli is already installed."
else
	echo	"Downloading wp-cli..."
	# location is not persistent
	wget -O	/usr/local/bin/wp-cli \
			https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	echo	"Setting permissions for wp-cli..."
	chmod +x /usr/local/bin/wp-cli
fi

wp-cli core is-installed --allow-root &> /dev/null || exit $?;

wp-cli config get DB_NAME --allow-root &> /dev/null || exit $?;
wp-cli config get DB_USER --allow-root &> /dev/null || exit $?;
wp-cli config get DB_PASSWORD --allow-root &> /dev/null || exit $?;
wp-cli config get DB_HOST --allow-root &> /dev/null || exit $?;

[ $(wp-cli user list --allow-root --format=count) -ge 2 ] || exit 1;

exit 0;
