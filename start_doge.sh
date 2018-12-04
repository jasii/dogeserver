#!/bin/sh

cp -n -R init/nut/conf/* nut/conf/
chown $PUID:$PGID -R .

cd server

while true
do
  # loop infinitely
  node server.js
  sleep 10
done
