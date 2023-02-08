# Ubuntu 22.10
# Based on https://github.com/sqitchers/docker-sqitch/blob/main/Dockerfile
FROM ubuntu:kinetic

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7 \
    && apt-get -qq update \
    && apt-get -qq --no-install-recommends install \
    apt-transport-https \
    less \
    libperl5.34 \
    perl-doc \
    nano \
    ca-certificates \
    gettext \
    liblist-moreutils-perl \
    libmoo-perl \
    libdbd-pg-perl \
    sqitch \
    postgresql-client \
    cpanminus \
    sqlite3 \
    firebird3.0-utils libfbclient2 \
    libpq5 postgresql-client \
    mariadb-client-core-10.6 libmariadb-dev-compat libdbd-mysql-perl \
    && apt-cache pkgnames | grep python | xargs apt-get purge -qq \
    && apt-cache pkgnames | grep libmagic | xargs apt-get purge -qq \
    && apt-get auto-remove -y \
    && apt-get clean \
    # Let libcurl find certs. https://stackoverflow.com/q/3160909/79202
    && mkdir -p /etc/pki/tls && ln -s /etc/ssl/certs /etc/pki/tls/ \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /usr/bin/mysql?* \
    && rm -rf /plibs /man /usr/share/man /usr/share/doc /usr/share/postgresql \
    /usr/share/nano /etc/nanorc \
    && find / -name '*.pod' | grep -v sqitch | xargs rm -rf \
    && find / -name '*.ph' -delete \
    && find / -name '*.h' -delete

RUN groupadd -r sqitch --gid=1024 \
    && useradd -r -g sqitch --uid=1024 -d /home sqitch \
    && chown -R sqitch:sqitch /home

# Set up environment, entrypoint, and default command.
ENV LESS=-R LC_ALL=C.UTF-8 LANG=C.UTF-8 SQITCH_EDITOR=nano SQITCH_PAGER=less
USER sqitch
WORKDIR /repo
ENTRYPOINT ["/bin/sqitch"]
CMD ["help"]
