ifndef VERBOSE
	MAKEFLAGS += --no-print-directory
endif

default: install

.PHONY: install lint unit

OS_ARCH=linux_amd64
HOSTNAME=registry.terraform.io
NAMESPACE=Kaginari
NAME=docker-utils
VERSION=9.9.9
## on linux base os
TERRAFORM_PLUGINS_DIRECTORY=${HOME}/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}


install:
	mkdir -p ${TERRAFORM_PLUGINS_DIRECTORY}
	go build -o ${TERRAFORM_PLUGINS_DIRECTORY}/terraform-provider-${NAME}
	cd examples && rm -rf .terraform && rm -f .terraform.lock.hcl
	cd examples && make init
re-install:
	rm -f ${TERRAFORM_PLUGINS_DIRECTORY}/terraform-provider-${NAME}
	go build -o ${TERRAFORM_PLUGINS_DIRECTORY}/terraform-provider-${NAME}
	cd examples && rm -rf .terraform && rm -f .terraform.lock.hcl
	cd examples && make init
lint:
	 golangci-lint run

