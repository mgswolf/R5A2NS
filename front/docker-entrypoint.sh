#!/bin/bash

if [ -f 'package.json']
  cp package.json /app
else
  cd app
  echo pwd
  npm init
  cp package.json /app
fi
