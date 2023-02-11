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
    ssl        on;
    ssl_certificate         /etc/ssl/certs/cert-$(echo "$1" | tr -d '.').pem;
    ssl_certificate_key     /etc/ssl/private/key-$(echo "$1" | tr -d '.').pem;

    server_name www.$1 $1;

    root /var/www/$1/out;
    index index.html;

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;

    client_max_body_size 50M;

    location / {
        try_files $uri $uri/ =404;
    }

    #enable gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1000;
    gzip_comp_level 5;
    gzip_types application/json text/css application/x-javascript application/javascript image/svg+xml;
    gzip_proxied any;

    # A long browser cache lifetime can speed up repeat visits to your page
    location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
        access_log        off;
        log_not_found     off;
        expires           360d;
    }

    # disable access to hidden files
    location ~ /\.ht {
        access_log off;
        log_not_found off;
        deny all;
    }
}
" > $1
