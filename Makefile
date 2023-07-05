# Include variables
-include .env
export

# Variables
DOCKER_VERSION ?= develop
DOCKER_PLATFORM ?= linux/amd64
NODE_ENV ?= production

###################################################
# HELP ############################################
##################################################
all:
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"}'
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# ################################################
# Development ####################################
# ################################################
.PHONY: install dev clean start strapi-build strapi-admin

install: ## Install all dependencies
	npm ci

dev: ## Start Strapi for local development
	NODE_ENV=development npm run develop

clean: ## Clean strapi files
	rm -rf .cache
	rm -rf build

start: ## Strapi start sequence (build + start)
	$(MAKE) strapi-build
	npm run start

strapi-build: ## Build Strapi CMS
	npm run build

strapi-admin: ## Strapi GUI development
	npx strapi develop --watch-admin

# ################################################
# Docker #########################################
# ################################################
.PHONY: docker-up
docker-up: ## Run docker containers
	docker-compose up -d

.PHONY: docker-build
docker-build: ## Docker image build
	docker buildx \
		build \
		--build-arg NODE_ENV=${NODE_ENV} \
		--platform ${DOCKER_PLATFORM} \
		-t ${DOCKER_IMAGE}:${DOCKER_VERSION} \
		-f Dockerfile \
		.

.PHONY: docker-push
docker-push: ## Push docker image to registry
	docker push ${DOCKER_IMAGE}:${DOCKER_VERSION}

.PHONY: docker-dev
docker-dev: ## Run docker image
	docker run \
		-it \
		--rm \
		-p 1337:1337 \
		-v $(CURDIR):/srv:cached \
		${DOCKER_IMAGE}:${DOCKER_VERSION}

.PHONY: docker-mariadb
docker-mariadb: ## Run mariadb container
	docker-compose up db

# ################################################
# Deploy #########################################
# ################################################

.PHONY: deploy
deploy: # Deploy to Fly.io
	fly deploy
