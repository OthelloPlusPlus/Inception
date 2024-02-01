# Pulling Debian
# 	Versions	https://www.debian.org/releases/
#		12.4	Bookworm (Stable)
#		11.8	Bullseye (Penultimate)
#		10.13	Buster	(oldoldstable)
FROM	debian:bullseye

LABEL	_author="Othello"\
		_project="Inception"

RUN		apt-get update
RUN		apt-get install -y --fix-missing \
						mariadb-server
RUN		apt-get clean \
	&&	rm -rf /var/lib/apt/lists/*

COPY	tools/entrypoint.sh		/tools/
COPY	tools/health_daemon.sh	/tools/
RUN 	chmod +x	/tools/entrypoint.sh\
					/tools/health_daemon.sh

EXPOSE 3306

HEALTHCHECK	--interval=1m --timeout=10s --retries=3 \
			CMD	/tools/health_daemon.sh

ENTRYPOINT	["/tools/entrypoint.sh"]
CMD	["mysqld_safe"]
# CMD ["tail", "-f", "/dev/null"]
