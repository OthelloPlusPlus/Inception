FROM inception:base

ENV	DEBIAN_FRONTEND noninteractive

# Installation
RUN		apt-get install -y --fix-missing \
			wget \
			php7.4-fpm \
			php7.4-mysqli \
			mariadb-client \
	&&	apt-get clean \
	&&	rm -rf /var/lib/apt/lists/* \
	&&	mkdir /run/php

# Import
COPY	conf/www.conf				/etc/php/7.4/fpm/pool.d/www.conf

COPY	tools/wordpress_setup.sh	/usr/local/bin/wordpress_setup.sh
COPY	/tools/health_daemon.sh	/usr/local/bin/health_daemon.sh
RUN		chmod +x	/usr/local/bin/wordpress_setup.sh \
					/usr/local/bin/health_daemon.sh
COPY	tools/add_post.sql	/usr/local/bin/add_post.sql
RUN		chmod +r	/usr/local/bin/add_post.sql

# Configuration
WORKDIR /var/www/html
EXPOSE	9000
HEALTHCHECK	--interval=1m --timeout=10s --retries=3 \
			CMD ["/usr/local/bin/health_daemon.sh"]

# Bootup
ENTRYPOINT	["/usr/local/bin/wordpress_setup.sh"]
CMD	["php-fpm7.4", "-F"]
# CMD ["tail", "-f", "/dev/null"]
