help:

start: ## Запустить проект
	@docker compose up -d

logs: ## Смотреть логи
	@docker compose logs -f

stop: ## Остановить проект
	@docker compose down

provision: ## Создать базу, заполнить тестовыми данными, создать константы и пользователей (db:setup bootstrap:create_constants bootstrap:create_admin)
	@docker exec lms-back rake db:setup bootstrap:create_constants bootstrap:create_admin

bundle: ## bundle install
	@docker exec lms-back bundle

npm: lms-ts ## npm install
	@docker exec lms-ts npm i

mig: lms-back ## rake db:migrate
	@docker exec lms-back rake db:migrate

seed: lms-back ## rake db:seed
	@docker exec lms-back rake db:seed

c: ## Консоль в Rails (rails c)
	@docker exec -it lms-back rails c

db: ## Консоль в Postgres (psql)
	@docker exec -it lms-postgres psql -U postgres -d lms_development

rspec: ## rspec
	@docker exec -e RAILS_ENV=test -e DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true lms-back rspec

rubocop: ## rubocop
	@docker exec lms-back rubocop

back-sh: ## Shell в back
	@docker exec -it lms-back /bin/sh

ts-sh:
	@docker exec -it lms-ts /bin/sh

# Restore
# docker exec -i lms-postgres pg_restore -U postgres -d lms_development -O < database.dump

.PHONY: help

help: ## Показать подсказку
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

lms-ts:
	@docker compose up -d lms-ts

lms-back:
	@docker compose up -d lms-back
