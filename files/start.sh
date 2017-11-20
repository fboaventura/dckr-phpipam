#!/bin/bash

echo -en "* Starting crond..."
cron
echo -en "* Starting apache..."
/usr/sbin/apache2 -D FOREGROUND
