install: install-backend
	@echo "==========================="
	@echo "=        Finished         ="
	@echo "==========================="

install-backend:
	@echo "==========================="
	@echo "=    Install backend      ="
	@echo "==========================="
	@./service/scripts/install-backend.sh

install-backend-with-env:
	@echo "==========================="
	@echo "=    Install backend      ="
	@echo "==========================="
	@./service/scripts/install-backend.sh -v

install-dev:
	@echo "==========================="
	@echo "=    Install dev deps     ="
	@echo "==========================="
	pip install -r requirements-dev.txt

run-dev: migrate
	make run-django & \
	make run-frontend

django-migrate: migrations migrate

migrations:
	./manage.py makemigrations

migrate:
	./manage.py migrate

superuser:
	./manage.py createsuperuser

run-django:
	./manage.py runserver

lint: flake8-lint isort-lint yapf-lint

format: yapf-format isort-format

flake8-lint:
	flake8 .

isort-lint:
	isort --check-only --diff --recursive .

isort-format:
	isort --recursive .

yapf-format:
	yapf -i -r --style .style.yapf -p -e "*/migrations/*.py" -e "env" -e "*/settings.py" . -e "neuronunit/**" -e "sciunit/**"

yapf-lint:
	yapf -d -r --style .style.yapf -e "*/migrations/*.py" -e "env" -e "*/settings.py" . -e "neuronunit/**" -e "sciunit/**"

generate-tags:
	ctags -R --exclude=.git --exclude=node_modules --exclude=dist --exclude=env .

git-clean-local: git-check-on-dev
	for b in `git branch --list "feature_*" --merged`; do git branch -d "$$b"; done;
	for b in `git branch --list "bug_*" --merged`; do git branch -d "$$b"; done;

git-check-on-dev:
	@git status -b -s | grep "## development...origin/development"
	@echo "On development"
