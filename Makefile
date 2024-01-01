ENV := $(PWD)/.env
GIT_SHA := $(giv rev-parse HEAD)
# Environment variables for project
include $(ENV)

# Export all variable to sub-make
export

build-client:
	@docker build ./client --tag $(CLIENT_IMAGE) 
	
build-server:
	@docker build ./server --tag $(SERVER_IMAGE)

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
	@docker login -u `oc whoami` -p `oc whoami --show-token $(OPENSHIFT_REGISTRY)`

tag-client:
	@docker tag  $(CLIENT_IMAGE):latest $(OPENSHIFT_REGISTRY)/$(PROJECT)/$(CLIENT_IMAGE):latest

tag-server:
	@docker tag  $(SERVER_IMAGE) $(OPENSHIFT_REGISTRY)/$(PROJECT)/$(SERVER_IMAGE):latest

push-client:
	@docker push $(OPENSHIFT_REGISTRY)/$(PROJECT)/$(CLIENT_IMAGE):latest

push-server:
	@docker push $(OPENSHIFT_REGISTRY)/$(PROJECT)/$(SERVER_IMAGE):latest

# TODO - include as part of GH actions
apply-server:
	@kubectl apply -f k8s/server

apply-client:
	@kubectl apply -f k8s/client