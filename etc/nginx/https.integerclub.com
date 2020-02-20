# https://example.com/
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name integerclub.com integerclub;

    ssl_certificate /etc/letsencrypt/live/integerclub.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/integerclub.com/privkey.pem;

    root /var/www/integerclub.com;
}

# https://www.example.com/ => https://example.com/
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name www.integerclub.com;

    ssl_certificate /etc/letsencrypt/live/integerclub.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/integerclub.com/privkey.pem;

    return 301 https://integerclub.com$request_uri;
}

# http://example.com/, http://www.example.com/ => https://example.com/
server {
    listen 80;
    listen [::]:80;
    server_name integerclub.com www.integerclub.com;
    return 301 https://integerclub.com$request_uri;
}
