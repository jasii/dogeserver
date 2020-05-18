#!/bin/sh

cp -n -R init/nut/conf/* nut/conf/
chown $PUID:$PGID -R .

cd server
node server.js
