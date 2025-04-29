# Inception

## Install VirtualBox Guest Additions:

- VM > Devices > "Insert Guest Additions CD Image"
- `sudo mount /dev/cdrom /media/cdrom`
- cd to /media/cdrom or /media/cdrom0
- `sudo ./VBoxLinuxAdditions.run`
- restart VM

Shared Clipboard and Drag and Drop in "Devices"

## Install Docker repository in Debian
[Docker Tutorial Link](https://docs.docker.com/engine/install/debian/#install-using-the-repository)

- Set up APT repository to download Docker from their source
- then install with apt
- test with `sudo docker run hello-world`

- optional: [create docker group, no sudo needed](https://docs.docker.com/engine/install/linux-postinstall/)

project_root/
│
|──secrets/ db_pw.txt , db_rootpw.txt wp_adminpw.txt (pw password demek)
├── srcs/
|	|──requirements
|	|	├── nginx/
|		| 		├── Dockerfile
│   	│   	├── nginx.conf
│  		│   	└── ssl/ (TLS sertifikaları buraya)
│   	│
│   	├── wordpress/
│   	│   	├── Dockerfile
│   	│   	└── wp-config.php
│   	│
│   	├── mariadb/
│   	│   ├── Dockerfile
│   	│   └── tools/
|		|			|──mariadb_script.sh
│
├── docker-compose.yml
├── Makefile
└── .env (çevresel değişkenler)
