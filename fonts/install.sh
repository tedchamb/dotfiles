#!/usr/bin/env bash
if [ "$(uname -s)" == "Linux" ]
then
    if [ "$(dpkg-query -W -f='${Status}' fonts-powerline 2>/dev/null | grep -c 'ok installed')" -eq 0 ];
    then
        sudo apt-get install fonts-powerline
    fi
fi
