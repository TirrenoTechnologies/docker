#!/bin/sh

uid="$(id -u)"
gid="$(id -g)"
if [ "$uid" = '0' ]; then
    case "$1" in
        apache2*)
            user="${APACHE_RUN_USER:-www-data}"
            group="${APACHE_RUN_GROUP:-www-data}"

        user="${user#'#'}"
        group="${group#'#'}"
        ;;
        *) # php-fpm
            user='www-data'
            group='www-data'
            ;;
    esac
else
    user="$uid"
    group="$gid"
fi
tar cf - --one-file-system -C /usr/src/tirreno . | tar xf -
chown -R "$user":"$group" .

exec "$@"

