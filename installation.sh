#bin/bash!

sudo docker compose build

sudo docker compose up -d

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py makemigrations"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py migrate"

sudo docker compose run --rm pyeditorial /bin/bash -c "./manage.py collectstatic"

sudo docker ps

