  echo 'nameserver 10.77.3.2' > /etc/resolv.conf
  apt-get update
  apt-get install apache2-utils -y
  apt-get install nginx -y
  apt-get install lynx -y

  service nginx start     

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php
echo ' upstream worker {
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream roundrobin_worker {
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream leastconn_worker {
    least_conn;
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream weightedrr_worker {
    server 10.77.1.1 weight=3;
    server 10.77.1.2 weight=2;
    server 10.77.1.3 weight=1;
}

upstream iphash_worker {
    ip_hash;
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

upstream hash_worker {
    hash $request_uri consistent;
    server 10.77.1.1;
    server 10.77.1.2;
    server 10.77.1.3;
}

server {
    listen 80;
    server_name harkonen.it27.com www.harkonen.it27.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
    }
    location /roundrobin {
        proxy_pass http://roundrobin_worker;
    }
    location /leastconn {
        proxy_pass http://leastconn_worker;
    }
    location /weightedrr {
        proxy_pass http://weightedrr_worker;
    }
    location /iphash {
        proxy_pass http://iphash_worker;
    }
    location /hash {
        proxy_pass http://hash_worker;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
