CMD_DOCKER	=	sudo docker
CMD_COMPOSE	=	sudo docker-compose
COMPOSE_DIR	=	./srcs/docker-compose.yaml
WP_VOL_DIR	=	/home/dilopez-/data/wordpress_data
DB_VOL_DIR	=	/home/dilopez-/data/mariadb_data

RED			=	$(shell tput -Txterm setaf 1)
GREEN		=	$(shell tput -Txterm setaf 2)
YELLOW		=	$(shell tput -Txterm setaf 3)
RESET		=	$(shell tput -Txterm sgr0)

all:
	@sudo mkdir -p $(WP_VOL_DIR)
	@sudo mkdir -p $(DB_VOL_DIR)
	@$(CMD_DOCKER) pull debian:buster
	@$(CMD_COMPOSE) -f $(COMPOSE_DIR) up -d --build

list:	
	@echo "$(YELLOW)\n-------------- Lista de contenedores --------------\n$(RESET)"
	@$(CMD_DOCKER) ps -a

list_volumes:
	@echo "$(YELLOW)\n---------------- Lista de volúmenes ---------------\n$(RESET)"
	@$(CMD_DOCKER) volume ls

stop: 
	@$(CMD_COMPOSE) -f $(COMPOSE_DIR) stop

start: 
	@$(CMD_COMPOSE) -f $(COMPOSE_DIR) start

re: clean all

clean: 
	@$(CMD_COMPOSE) -f $(COMPOSE_DIR) down
	@if [ -n "$$($(CMD_DOCKER) images -qa)" ]; then $(CMD_DOCKER) rmi -f $$($(CMD_DOCKER) images -qa); fi
	@if [ -n "$$($(CMD_DOCKER) volume ls -q)" ]; then $(CMD_DOCKER) volume rm -f $$($(CMD_DOCKER) volume ls -q); fi
	@sudo rm -rf $(WP_VOL_DIR)
	@sudo rm -rf $(DB_VOL_DIR)
	@echo "$(GREEN)Limpiado con exito!$(RESET)"

.PHONY: all list list_volumes stop start re clean