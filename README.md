# fboaventura/dckr-phpipam

Docker instance to run [phpipam](https://phpipam.net/) with a low footprint.

## How to use

This instance is published at [Docker Hub](https://hub.docker.com/r/fboaventura/dckr-phpipam/), so it's publicly available.  All you need to run this instance is:

```bash
$ docker run -d -v `pwd`:/app/www -p 8080:80 fboaventura/dckr-phpipam
```

You can, of course, pass some custom values to fiche, in order to make it more prone to your usage.  The variables, and their defaults are:

```dockerfile
ENV APACHE_LOCK_DIR /var/lock
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2/
ENV APACHE_PID_FILE /var/apache.pid

ENV SSL_ENABLED false
ENV PROXY_ENABLED false

ENV VERSION 1.3
```

Once the instance is running, all you have to do is open a web browser and point it to `http://${DOMAIN}:8080`


