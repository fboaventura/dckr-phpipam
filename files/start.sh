#!/bin/bash

env | grep ^MYSQL > /.mydata
echo "* Starting crond..."
cron
echo "* Starting apache..."
/usr/sbin/apache2 -D FOREGROUND
