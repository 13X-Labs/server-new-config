#!/bin/bash

# Check if a parameter was provided
if [ $# -eq 0 ]; then
  echo "Error: No parameter provided."
  echo "Usage: ./make-file-nginx <parameter>"
  exit 1
fi

ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/$1