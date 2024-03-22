
pgrep -x "php-fpm7.4" &> /dev/null || exit $?;

mariadb -h$DB_HOST -u$DB_USER -p$DB_PASSWORD -e "USE $DB_NAME;" &> /dev/null || exit $?;

if which wp-cli &> /dev/null; then
	msg	"wp-cli is already installed."
else
	msg	"Downloading wp-cli..."
	# location is not persistent
	wget -O	/usr/local/bin/wp-cli \
			https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	msg	"Setting permissions for wp-cli..."
	chmod +x /usr/local/bin/wp-cli
fi

wp-cli core is-installed --allow-root || exit $?;

wp-cli config get DB_NAME --allow-root || exit $?;
wp-cli config get DB_USER --allow-root || exit $?;
wp-cli config get DB_PASSWORD --allow-root || exit $?;
wp-cli config get DB_HOST --allow-root || exit $?;

[ $(wp-cli user list --allow-root --format=count) -lt 2 ] || exit 1;
