tag ?= latest

version ?= $(shell yq e '.version' charts/whoami-go/Chart.yaml)

app:
	go build -o whoami-go -ldflags "-s -w" .

image:
	KO_DOCKER_REPO=tons ko publish --base-import-paths --tags=$(tag) .

alpine-image:
	IMAGE_TAG=$(tag) docker-compose build prod && IMAGE_TAG=$(tag) docker-compose push prod

helm-package:
	@helm package helm/

publish-helm:
	@curl --user "$(CHARTMUSEUM_AUTH_USER):$(CHARTMUSEUM_AUTH_PASS)" \
        -F "chart=@whoami-go-$(version).tgz" \
        https://helm-charts.fitfit.dk/api/charts

.PHONY: image helm publish-helm
