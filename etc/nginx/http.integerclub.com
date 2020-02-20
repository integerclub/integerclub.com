# http://example.com/
server {
    listen 80;
    listen [::]:80;
    server_name integerclub.com integerclub;
    root /var/www/integerclub.com;
}

# http://www.example.com/ => http://example.com/
server {
    listen 80;
    listen [::]:80;
    server_name www.integerclub.com;
    return 301 http://integerclub.com$request_uri;
}
