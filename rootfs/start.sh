#!/bin/bash

if [ ! -f "/data/appsettings.json" ]; then
    echo "Populating /data/appsettings.json."
    cp /etc/opt/appveyor/server/appsettings.json.example /data/appsettings.json
fi

chown -R appveyor:appveyor /data

sudo -u appveyor /opt/appveyor/server/appveyor-server