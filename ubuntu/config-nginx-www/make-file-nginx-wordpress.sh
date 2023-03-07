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

  root /var/www/$1;
  index index.php index.html index.htm;

  location / {
    try_files $uri $uri/ /index.php?$args;
  }
  
   location ~ ^/wp-json/ {
     rewrite ^/wp-json/(.*?)$ /?rest_route=/$1 last;
   }

  location ~ ([^/]*)sitemap(.*).x(m|s)l$ {
    ## this rewrites sitemap.xml to /sitemap_index.xml
    rewrite ^/sitemap.xml$ /sitemap_index.xml permanent;
    ## this makes the XML sitemaps work
    rewrite ^/([a-z]+)?-?sitemap.xsl$ /index.php?yoast-sitemap-xsl=$1 last;
    rewrite ^/sitemap_index.xml$ /index.php?sitemap=1 last;
    rewrite ^/([^/]+?)-sitemap([0-9]+)?.xml$ /index.php?sitemap=$1&sitemap_n=$2 last;
    ## The following lines are optional for the premium extensions
    ## News SEO
    rewrite ^/news-sitemap.xml$ /index.php?sitemap=wpseo_news last;
    ## Local SEO
    rewrite ^/locations.kml$ /index.php?sitemap=wpseo_local_kml last;
    rewrite ^/geo-sitemap.xml$ /index.php?sitemap=wpseo_local last;
    ## Video SEO
    rewrite ^/video-sitemap.xsl$ /index.php?yoast-sitemap-xsl=video last;
  }

  error_page 404 /404.html;
  error_page 500 502 503 504 /50x.html;

  client_max_body_size 50M;

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
    include snippets/fastcgi-php.conf;
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
" > /etc/nginx/sites-available/$1
