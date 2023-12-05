#bin/bash!

cp ./local-default.conf ./config/nginx/conf.d/local.conf #resetting nginx server config to default


# Add Docker's official GPG key:
sudo apt-get -y update

sudo apt-get -y install ca-certificates curl gnupg

sudo install -y -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -y update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose 

sudo usermod -aG docker $USER

sudo systemctl enable docker.service

sudo systemctl enable containerd.service

sleep 2

sudo docker compose build

sudo docker compose up -d

echo migration starting in 15 seconds...

sleep 15

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py makemigrations content"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py migrate"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py collectstatic"

echo generating ssl

sleep 5

sudo docker exec -d pyeditorial-nginx-1 openssl req -x509 -nodes -subj '/C=TR' -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

sleep 2

sudo docker cp ./local.conf pyeditorial-nginx-1:/etc/nginx/conf.d

sleep 2

sudo docker stop pyeditorial-nginx-1

sleep 2

sudo docker start pyeditorial-nginx-1





