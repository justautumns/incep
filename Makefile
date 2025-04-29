
# # Varsayılan hedef (sadece 'make' yazınca çalışacak)
# all: ssl build up

# # Tüm süreci yeniden başlat
# re: fclean all

# # Docker imajlarını oluştur ve container'ları başlat
# build:
# 	@mkdir -p /home/$(USER)/data/wordpress
# 	@mkdir -p /home/$(USER)/data/mariadb
# 	@docker compose build

# # Container'ları başlat
# up:
# 	@docker compose up -d

# # Container'ları durdur
# down:
# 	@docker compose down

# # Container'ları durdur ve temizle
# clean: down
# 	@docker system prune -a --force

# # Tamamen temizle (container, volume, image)
# fclean: clean
# 	@sudo rm -rf /home/$(USER)/data
# 	@rm -rf ./srcs/requirements/nginx/ssl

# # SSL sertifikalarını oluştur
# ssl:
# 	@mkdir -p ./srcs/requirements/nginx/ssl
# 	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# 		-keyout ./srcs/requirements/nginx/ssl/yourlogin.42.fr.key \
# 		-out ./srcs/requirements/nginx/ssl/yourlogin.42.fr.crt \
# 		-subj "/C=TR/ST=Istanbul/L=Istanbul/O=42School/OU=IT/CN=yourlogin.42.fr" > /dev/null 2>&1

# .PHONY: all re clean fclean ssl

.PHONY: all build up down clean fclean re

all: build up

build:
	@echo "Docker images are being built"
	@mkdir -p /home/$(USER)/data/wordpress /home/$(USER)/data/mariadb
	docker compose build

up:
	@echo "Building up Emre great work!"
	docker compose up -d

down:
	docker compose down

clean: down
	docker system prune -a --force

fclean: clean
	sudo rm -rf /home/$(USER)/data
	rm -rf ./srcs/requirements/nginx/ssl

re: fclean all

ssl:
	@echo "This is necessary sssh!"
	@mkdir -p ./srcs/requirements/nginx/ssl
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout ./srcs/requirements/nginx/ssl/yourlogin.42.fr.key \
		-out ./srcs/requirements/nginx/ssl/yourlogin.42.fr.crt \
		-subj "/C=TR/ST=Istanbul/L=Istanbul/O=42School/OU=IT/CN=yourlogin.42.fr"
