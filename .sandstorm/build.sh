#!/bin/bash
set -euo pipefail
VENV=/opt/app/venv
if [ ! -d $VENV ] ; then
    virtualenv --python=python3 $VENV
else
    echo "$VENV exists, moving on"
fi

# See: https://stackoverflow.com/questions/42997258/virtualenv-activate-script-wont-run-in-bash-script-with-set-euo
set +u
source $VENV/bin/activate
set -u

pip3 install -r /opt/app/requirements.txt
python3 /opt/app/manage.py collectstatic --no-input
