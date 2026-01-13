all:
	@mkdir -p $(HOME)/data/mariadb
	@mkdir -p $(HOME)/data/wordpress
	@docker-compose -f ./docker-compose.yml up --build

down:
	@docker-compose -f ./docker-compose.yml down

re: down all

clean:
	@docker-compose -f ./docker-compose.yml down -v

fclean: clean
	@rm -rf $(HOME)/data/mariadb
	@rm -rf $(HOME)/data/wordpress

.PHONY: all down re clean fclean