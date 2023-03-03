#!/bin/bash

# Check if a parameter was provided
if [ $# -eq 0 ]; then
  echo "Error: No parameter provided."
  echo "Usage: ./make-file-nginx <parameter>"
  exit 1
fi


echo "
server {
    listen 80;
    listen [::]:80;
    server_name www.$1 $1;
}

server {
    #SSL Config
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    ssl_certificate         /etc/ssl/certs/cert-$(echo "$1" | tr -d '.').pem;
    ssl_certificate_key     /etc/ssl/private/key-$(echo "$1" | tr -d '.').pem;

    server_name www.$1 $1;

    root /var/www/$1/out;
    index index.html;
}
" > /etc/nginx/sites-available/$1
