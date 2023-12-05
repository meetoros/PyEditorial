#bin/bash!

cp ./local-default.conf ./config/nginx/conf.d/local.conf # Reset nginx server config to default. It is important to start the container


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

sudo apt-get -y update # Update repos

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose # Install docker

sudo usermod -aG docker $USER # Add user to group docker

sudo systemctl enable docker.service

sudo systemctl enable containerd.service

sleep 2

sudo docker compose build # Build 

sudo docker compose up -d # Create and start in detach mode

echo migration starting in 15 seconds... # Wait containers runs properly before migration

sleep 15

# Start migration

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py makemigrations content"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py migrate"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py collectstatic"

# Start ssl generation

echo generating ssl certificate in 5 seconds...

sleep 5

# Run openssl command inside nginx container with subcommand options to pass a variable TR 
sudo docker exec -d pyeditorial-nginx-1 openssl req -x509 -nodes -subj '/C=TR' -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

sleep 2

sudo docker cp ./local.conf pyeditorial-nginx-1:/etc/nginx/conf.d # Copy the configuration to use ssl certificate

sleep 2

# Restart the container to use new configuration

sudo docker stop pyeditorial-nginx-1

sleep 2

sudo docker start pyeditorial-nginx-1





