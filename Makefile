COMPOSE_DIR	=	./srcs/docker-compose.yml
WP_VOL_DIR	=	/home/dilopez-/data/wordpress
DB_VOL_DIR	=	/home/dilopez-/data/mariadb

RED			=	"\\x1b[31m"
GREEN		=	"\\x1b[32m"
YELLOW		=	"\\x1b[33m"
RESET		=	"\\x1b[37m"

all:
	@sudo mkdir -p $(WP_VOL_DIR)
	@sudo mkdir -p $(DB_VOL_DIR)
	@sudo docker-compose -f $(COMPOSE_DIR) up -d

list:	
	@echo "$(YELLOW) Lista de contenedores... $(RESET)"
	sudo docker ps -a

list_volumes:
	@echo "$(PURPLE)Lista de volumenes...$(RESET)"
	sudo docker volume ls

stop: 
	@sudo docker-compose -f $(COMPOSE_DIR) stop

start: 
	@sudo docker-compose -f $(COMPOSE_DIR) start

clean: 
	@sudo docker-compose -f $(COMPOSE_DIR) down
	@sudo rm -rf $(WP_VOL_DIR)
	@sudo rm -rf $(DB_VOL_DIR)

.PHONY: all list list_volumes stop start clean