#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y nginx uwsgi uwsgi-plugin-python3 python3-pip python-virtualenv git
service nginx stop
systemctl disable nginx
