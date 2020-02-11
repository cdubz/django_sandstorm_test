#!/bin/bash
set -euo pipefail
mkdir -p /var/lib/nginx
mkdir -p /var/log
mkdir -p /var/log/nginx
mkdir -p /var/sqlite3
rm -rf /var/run
mkdir -p /var/run
rm -rf /var/tmp
mkdir -p /var/tmp

cd /opt/app

# See: https://stackoverflow.com/questions/42997258/virtualenv-activate-script-wont-run-in-bash-script-with-set-euo
set +u
source venv/bin/activate
set -u

python3 /opt/app/manage.py migrate
DJANGO_SUPERUSER_PASSWORD=admin python3 /opt/app/manage.py createsuperuser --no-input --username=admin --email=admin@admin.admin || true

UWSGI_SOCKET_FILE=/var/run/uwsgi.sock

# Spawn uwsgi
HOME=/var uwsgi \
  --socket $UWSGI_SOCKET_FILE \
  --plugin python3 \
  --virtualenv /opt/app/venv \
  --module django_sandstorm_test.wsgi:application \
  --wsgi-file /opt/app/django_sandstorm_test/wsgi.py &


# Wait for uwsgi to bind its socket
while [ ! -e $UWSGI_SOCKET_FILE ] ; do
    echo "waiting for uwsgi to be available at $UWSGI_SOCKET_FILE"
    sleep .2
done

# Start nginx.
/usr/sbin/nginx -c /opt/app/.sandstorm/service-config/nginx.conf -g "daemon off;"

