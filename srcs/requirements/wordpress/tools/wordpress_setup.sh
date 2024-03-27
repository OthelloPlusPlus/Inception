#! /bin/bash

set -e
# CONFIG_FILE="/var/www/html/wp-config.php"
WWWCONF='/etc/php/7.4/fpm/pool.d/www.conf';

C_RESET="\x1b[0m"
C_DGRAY="\x1b[38;2;64;64;64m"
C_DRED="\x1b[38;2;128;0;0m"

# =====================================||===================================== #
#																			   #
#								   Functions								   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

function	config_wp_cli()
{
	if grep -q "env\[$1\]" "$WWWCONF"; then
		STORED_VALUE=$(grep -E "^\s*env\[$1\]\s*=" "$WWWCONF" | cut -d '=' -f 2- | awk '{$1=$1};1')
		STORED_VALUE=$(eval "echo $STORED_VALUE")
		if [ -n "$STORED_VALUE" ]; then
			if [ -n "$2" ]; then
				msg	"Setting $1 to getenv($2)."
				wp-cli config set "$1" "getenv('$2')"	--allow-root \
														--path=/var/www/html \
														--raw
			else
				errmsg	"Nothing to set getenv() to."
			fi
		else
			errmsg	"env[$1] is empty. getenv() not set."
		fi
	else
		errmsg	"env[$1] not found. getenv() not set."
	fi
}

function	msg()
{
	echo -e	"$C_DGRAY""$1""$C_RESET"
}

function	errmsg()
{
	echo -e	"$C_DRED""Error: "
	msg	"$1"
}

# =====================================||===================================== #
#																			   #
#									 Script									   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

# wp-cli
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

# wp-cli core download
if [ -f "/var/www/html/wp-config.php" ]; then
	msg	"WordPress is already downloaded."
else
	msg	"Downloading WordPress..."
	wp-cli core download	--allow-root \
							--path=/var/www/html
fi

# wp-config.php setup
if wp-cli config path --allow-root &> /dev/null; then
	msg	"wp-config.php already exists."
else
	msg	"Creating wp-config.php..."
	wp-cli config create	--allow-root \
							--path=/var/www/html \
							--dbname="$DB_NAME" \
							--dbuser="$DB_USER" \
							--dbpass="$DB_PASSWORD" \
							--dbhost="$DB_HOST"
fi

# wp-config.php configuration
msg	"Configuring wp-config.php"
config_wp_cli	"DB_NAME"		"DB_NAME"
config_wp_cli	"DB_USER"		"DB_USER"
config_wp_cli	"DB_PASSWORD"	"DB_PASSWORD"
config_wp_cli	"DB_HOST"		"DB_HOST"

# wp-cli core install
if wp-cli core is-installed --allow-root; then
	msg	"WordPress is already installed."
else
	msg	"Installing WordPress with admin $WP_ADMIN..."
	wp-cli core install	--allow-root \
						--url="$DOMAIN" \
						--title="$WP_TITLE" \
						--admin_user="$WP_ADMIN" \
						--admin_password="$WP_ADMIN_PWD" \
						--admin_email="$WP_ADMIN_MAIL" \
						--skip-email
fi

# wp-cli user create
if wp-cli user get "$WP_USER" --allow-root &> /dev/null; then
	msg	"User $WP_USER already exists.";
else
	msg	"Creating user $WP_USER..."
	wp-cli user create	--allow-root \
						"$WP_USER" \
						"$WP_USER_MAIL" \
						--user_pass=$PASSWORD_LOW \
						--role="editor" \
						--porcelain
fi

# Adding post to wordpress
msg	"Adding post to wordpress at ID 23"
envsubst < /usr/local/bin/add_post.sql | mariadb -h$DB_HOST -u$DB_USER -p$DB_PASSWORD

# wp-cli user list
msg	"Displaying users:"
wp-cli user list --allow-root --orderby=roles --order=desc --number=9 --format=table

exec	"$@" && echo "Completed [$@]" || echo "Failed [$@]"
