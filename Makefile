COLOR := $(shell git rev-parse HEAD | cut -c 1-6)
DOCKER_IMAGE ?= rainbow-mnemonic
GCLOUD_PROJECT ?= maas-kube-rainbow

.PHONY: build
build: rainbow-mnemonic

rainbow-mnemonic: main.go
	go build -o rainbow-mnemonic

.PHONY: image
image:
	@echo Building with color $(COLOR)
	COLOR=$(COLOR) docker build . -t $(DOCKER_IMAGE):$(COLOR) --build-arg COLOR=$(COLOR) -f Dockerfile

.PHONY: push
push: image
	docker push $(DOCKER_IMAGE):$(COLOR)

.PHONY: push-gcloud
push-gcloud: 
	docker tag $(DOCKER_IMAGE):$(COLOR) gcr.io/$(GCLOUD_PROJECT)/$(DOCKER_IMAGE):$(COLOR)
	gcloud docker -- push gcr.io/$(GCLOUD_PROJECT)/$(DOCKER_IMAGE):$(COLOR)

.PHONY: submit-gcloud
submit-gcloud: 
	gcloud container builds submit --tag gcr.io/$(GCLOUD_PROJECT)/$(DOCKER_IMAGE):$(COLOR) .


.PHONY: install
install:
	cat app.yaml | sed s/__COLOR__/$(COLOR)/g | kubectl apply -f -
	kubectl expose deployment $(DOCKER_IMAGE)-$(COLOR) --type "LoadBalancer"
	kubectl get service $(DOCKER_IMAGE)-$(COLOR)

.PHONY: setup-gcloud
setup-gcloud:
# I followed the quickstart guides from GCP to:
#   * Set up a container registry
#	  https://cloud.google.com/container-registry/docs/quickstart
#   * Set up triggered builds of my containers
#	  https://cloud.google.com/container-builder/docs/quickstart-docker
#   * Set up a GKE cluster and run deployments
#	  https://cloud.google.com/kubernetes-engine/docs/quickstart
	gcloud config set project $(GCLOUD_PROJECT)
	#gcloud auth login
	gcloud config set compute/zone us-east4-a
	gcloud container clusters create test-cluster
	gcloud container clusters get-credentials test-cluster
