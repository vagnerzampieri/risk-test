start:
	docker compose up -d

stop:
	docker compose down

server:
	foreman start -f Procfile.dev

console:
	bundle exec rails console

install:
	bundle install

other_install:
	gem install foreman

setup_db:
	bundle exec rails db:setup

migrate:
	bundle exec rails db:migrate

test:
	bundle exec rspec
