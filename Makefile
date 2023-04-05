COMPOSE_DIR	=	./srcs/docker-compose.yml
WP_VOL_DIR	=	/home/dilopez-/data/wordpress_data
DB_VOL_DIR	=	/home/dilopez-/data/mariadb_data

RED			=	$(shell tput -Txterm setaf 1)
GREEN		=	$(shell tput -Txterm setaf 2)
YELLOW		=	$(shell tput -Txterm setaf 3)
RESET		=	$(shell tput -Txterm sgr0)

all:
	@sudo mkdir -p $(WP_VOL_DIR)
	@sudo mkdir -p $(DB_VOL_DIR)
	@sudo docker-compose -f $(COMPOSE_DIR) up -d

list:	
	@echo "$(YELLOW)\n-------------- Lista de contenedores --------------\n$(RESET)"
	@sudo docker ps -a

list_volumes:
	@echo "$(YELLOW)\n---------------- Lista de volúmenes ---------------\n$(RESET)"
	@sudo docker volume ls

stop: 
	@sudo docker-compose -f $(COMPOSE_DIR) stop

start: 
	@sudo docker-compose -f $(COMPOSE_DIR) start

clean: 
	@sudo docker-compose -f $(COMPOSE_DIR) down
	@sudo docker rmi -f srcs-nginx
	@sudo rm -rf $(WP_VOL_DIR)
	@sudo rm -rf $(DB_VOL_DIR)
	@echo "$(GREEN)Limpiado con exito!$(RESET)"

.PHONY: all list list_volumes stop start clean