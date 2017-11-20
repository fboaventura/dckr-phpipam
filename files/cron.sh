#!/bin/bash

set -a
source /.mydata
set +a

/usr/bin/php /var/www/html/functions/scripts/pingCheck.php 1>/tmp/ping.log 2>&1
/usr/bin/php /var/www/html/functions/scripts/discoveryCheck.php 1>/tmp/discovery.log 2>&1

