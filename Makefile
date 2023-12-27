ENV := $(PWD)/.env

# Environment variables for project
include $(ENV)

# Export all variable to sub-make
export


build-client:
	@docker-compose up --build -d client

build-server:
	@docker-compose up --build -d server

stop:
	@docker-compose down


oc-registry-login:
	@oc registry login

oc-registry-info:
	@oc registry info

oc-create-client-imagestream:
	@oc create imagestream $(CLIENT_IMAGE)

oc-create-server-imagestream:
	@oc create imagestream $(SERVER_IMAGE)

docker-oc-login:
	@docker login -u `oc whoami` -p `oc whoami --show-token $(REGISTRY)

tag-client:
	@docker tag  $(CLIENT_IMAGE):latest $(REGISTRY)/$(PROJECT)/$(CLIENT_IMAGE):latest

tag-server:
	@docker tag  $(SERVER_IMAGE) $(REGISTRY)/$(PROJECT)/$(SERVER_IMAGE):latest

push-client:
	@docker push $(REGISTRY)/$(PROJECT)/$(CLIENT_IMAGE):latest

push-server:
	@docker push $(REGISTRY)/$(PROJECT)/$(SERVER_IMAGE):latest

# TODO - include as part of GH actions
apply-server:
	@kubectl apply -f k8s/server

apply-client:
	@kubectl apply -f k8s/client