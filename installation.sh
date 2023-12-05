#bin/bash!

sudo docker compose build

sudo docker compose up -d

echo waiting to run database before migration

sleep 15

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py makemigrations"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py migrate"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py makemigrations content"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py migrate"

sudo docker ps

