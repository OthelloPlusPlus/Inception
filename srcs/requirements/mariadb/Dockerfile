FROM inception:base

# Installation
RUN		apt-get install -y --fix-missing \
			mariadb-server \
			gettext-base \
	&&	apt-get clean \
	&&	rm -rf /var/lib/apt/lists/*

# Import
COPY	conf/50-server.conf		/etc/mysql/mariadb.conf.d/50-server.cnf

COPY	conf/mariadb.conf		/etc/mysql/mariadb.cnf
RUN		chmod 664	/etc/mysql/mariadb.cnf

COPY	tools/mariadb_setup.sh	/usr/local/bin/mariadb_setup.sh
COPY	tools/health_daemon.sh	/usr/local/bin/health_daemon.sh
RUN		chmod +x	/usr/local/bin/mariadb_setup.sh \
					/usr/local/bin/health_daemon.sh


# Configuration
EXPOSE	3306
HEALTHCHECK	--interval=1m --timeout=10s --retries=3 \
			CMD ["/usr/local/bin/health_daemon.sh"]

# Bootup
ENTRYPOINT	["/usr/local/bin/mariadb_setup.sh"]
CMD	["mariadbd"]
# CMD ["tail", "-f", "/dev/null"]
