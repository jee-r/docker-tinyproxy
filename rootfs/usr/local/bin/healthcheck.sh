#!/bin/sh

GETIP=$(curl --silent --proxy http://127.0.0.1:8888 --connect-timeout 100 --max-time 119 ifconfig.co)

if [ "$?" == 0 ]; then 
  echo "PROXY OK $GETIP" && exit 0
else 
  echo "PROXY FAILED $GETIP" && exit 1
fi

exit 0
