# ---- Config ----
APP_NAME=brain-budget-api
PORT=8000
IMAGE=$(APP_NAME):latest
CONTAINER=$(APP_NAME)-container

# ---- Local dev (no Docker) ----
dev:
	uv run uvicorn src.main:app --reload --host 0.0.0.0 --port $(PORT)

install:
	uv sync

# ---- Docker ----
build:
	docker build -f docker/Dockerfile -t $(IMAGE) .

run:
	docker run -d -p $(PORT):8000 --name $(CONTAINER) $(IMAGE)

stop:
	docker stop $(CONTAINER) || true
	docker rm $(CONTAINER) || true

restart: stop run

logs:
	docker logs -f $(CONTAINER)

# ---- Docker Compose ----
up:
	docker compose -f docker-compose.yaml up --build

down:
	docker compose -f docker-compose.yaml down

# ---- Cleanup ----
clean:
	docker system prune -f

# ---- Debug ----
shell:
	docker compose exec api /bin/sh

stats:
	docker stats $(docker compose ps -q)
