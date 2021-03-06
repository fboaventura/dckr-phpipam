FROM ubuntu:19.10

# To use apt-cacher-ng while building locally
#ADD files/deb-proxy.conf /etc/apt/apt.conf.d/10-proxy

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install cron apache2 libapache2-mod-php php-mysql vim curl fping php-gmp php-ldap \
       php-pear php-mbstring php-gd php-curl php-cli php-snmp \
    && apt-get clean \
    && mkdir -p /var/www/html/ /var/lock /var/run \
    && phpenmod snmp \
    && rm /var/www/html/index.html

RUN a2enmod rewrite

VOLUME ["/ssl"]

EXPOSE 80 443

#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
CMD ["/start.sh"]

ADD files/crontab /etc/cron.d/phpipam
ADD files/start.sh files/cron.sh /

RUN chmod 0644 /etc/cron.d/phpipam \
    && chmod 0755 /start.sh /cron.sh


ENV APACHE_LOCK_DIR="/var/lock" \
        APACHE_RUN_DIR="/var/run" \
        APACHE_RUN_USER="www-data" \
        APACHE_RUN_GROUP="www-data" \
        APACHE_LOG_DIR="/var/log/apache2/" \
        APACHE_PID_FILE="/var/apache.pid"

ENV SSL_ENABLED false
ENV PROXY_ENABLED false

ENV VERSION 1.4

ADD https://github.com/phpipam/phpipam/archive/${VERSION}.tar.gz /tmp
RUN tar -xzf /tmp/${VERSION}.tar.gz -C /var/www/html --strip-components=1

COPY files/default-vhost.conf /etc/apache2/sites-available/000-default.conf
COPY files/config.php /var/www/html

# Metadata params
ARG BUILD_DATE
ARG VCS_URL
ARG VCS_REF
ARG AUTHOR
ARG VENDOR

# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="PHP-IPAM" \
      org.label-schema.description="IP Address Management." \
      org.label-schema.url="https://frederico.cf" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="$VENDOR" \
      org.label-schema.version="$VERSION" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.author="$AUTHOR" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="MIT"

