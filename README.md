# PyEditorial
A free, open-source Blog CMS based on the "Django" and "Editorial" HTML5 theme. Ubuntu 22.04, Docker, Nginx, Gunicorn, Postgresql.
------------
### Aim and explanation of the structure
Aim of the project is to supply an installation bash script on a cleanOS (Ubuntu 22.04 LTS) with dockerized development environment. 

PyEditorial application is served with nginx 1.18.0 and gunicorn 20.1.0 by using HTTPS protocol. SSL certificate provided as self-signed. However, project is designed to create certificate while runing the installation script so, it can be unique for every user of this repository. 

Since, project aims to run the script on cleanOS, script will be install all neccessary tools such as docker. 

Development environment runs on three docker container:
- Application
- Web server
- Database

![Structure-Diagram drawio](https://github.com/meetoros/PyEditorial/assets/60683483/f7d45f70-f6ee-4ce3-92c0-415c1823b269)

------------
### Prerequisites
- Clean installation of Ubuntu 22.04 LTS
- git
------------
### How to install and run 

Warning! Script is designed for development purposes and local environment only.

1. Clone the repository and run the script
```
git clone https://github.com/meetoros/PyEditorial	  # clone the project
cd PyEditorial		                                  # go to the project DIR
sudo bash installation.sh                           # run the installation script
```

2. Go to  `https://127.0.0.1:8000/` to use project
------------
### Admin panel usage
Before using admin panel a super user needs to be created to login. Afrer installation is done run command:
```
sudo docker exec -it pyeditorial-pyeditorial-1 ./manage.py createsuperuser
```
After creating super user go to `https://127.0.0.1:8000/admin` and login with user that you have created.
