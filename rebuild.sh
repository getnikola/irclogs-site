#!/bin/bash
cd /home/kwpolska/nikola-logs
NIKOLA_DEBUG=1 /home/kwpolska/virtualenvs/nikola/bin/nikola build > last-rebuild.log 2>&1
if [[ $? != 0 ]]; then
    # error reporting
    mailfn='last-error-email'
    dold=$(cat $mailfn)
    dnow=$(date "+%s")

    if [[ $[$dnow - $dold] -gt 86400 ]]; then
        echo "Nikola Logs build error."
        echo
        cat last-rebuild.log
        echo -n $dnow > $mailfn
    fi
fi
