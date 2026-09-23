#! /bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
sudo ln -sf "$SCRIPTPATH"/canoncat.sh /usr/bin/canoncat
sudo ln -sf "$SCRIPTPATH"/canoncat_completion.sh /etc/bash_completion.d/canoncat_completion
