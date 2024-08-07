#!/bin/sh

# Start Nginx

#sudo apt update
#sudo apt install nginx -y
sudo apt-get update

export APORT=$(hostname -I)

sudo tee /etc/nginx/sites-available/mypage.conf > /dev/null <<EOL
server {
    listen 80;
    server_name $APORT;

    location / {
        proxy_pass http://${backend_url}:9090/dptweb-0.0.1/;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/mypage.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx