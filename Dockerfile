FROM ubuntu:17.04

LABEL org.label-schema.build-date="2017-09-12T07:30:15Z" \
            org.label-schema.docker.dockerfile="/Dockerfile" \
            org.label-schema.license="MIT" \
            org.label-schema.name="PHPIpam" \
            org.label-schema.url="https://frederico.cf" \
            org.label-schema.vcs-ref="d7ef28d" \
            org.label-schema.vcs-type="Git" \
            org.label-schema.vcs-url="https://github.com/fboaventura/dckr-phpipam.git"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
                                && apt-get -y install apache2 libapache2-mod-php php-mysql vim curl fping php-gmp php-ldap php-pear \
                                && apt-get clean \
                                && mkdir -p /var/www/html/ /var/lock /var/run

RUN a2enmod rewrite

VOLUME ["/ssl"]

EXPOSE 80 443

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

ENV APACHE_LOCK_DIR /var/lock
ENV APACHE_RUN_DIR /var/run
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2/
ENV APACHE_PID_FILE /var/apache.pid

ENV SSL_ENABLED false
ENV PROXY_ENABLED false

ENV VERSION 1.3

ADD https://github.com/phpipam/phpipam/archive/${VERSION}.tar.gz /tmp
RUN tar -xzf /tmp/${VERSION}.tar.gz -C /var/www/html --strip-components=1

COPY files/default-vhost.conf /etc/apache2/sites-available/000-default.conf
COPY files/config.php /var/www/html

