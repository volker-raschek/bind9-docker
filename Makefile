# CONTAINER_RUNTIME
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image.
CONTAINER_RUNTIME?=$(shell which docker)

# BIND9_IMAGE_REGISTRY_NAME
# Defines the name of the new container to be built using several variables.
BIND9_IMAGE_REGISTRY_NAME:=docker.io
BIND9_IMAGE_REGISTRY_USER:=volkerraschek

BIND9_IMAGE_NAMESPACE?=${BIND9_IMAGE_REGISTRY_USER}
BIND9_IMAGE_NAME:=bind9
BIND9_IMAGE_VERSION?=latest
BIND9_IMAGE_FULLY_QUALIFIED=${BIND9_IMAGE_REGISTRY_NAME}/${BIND9_IMAGE_NAMESPACE}/${BIND9_IMAGE_NAME}:${BIND9_IMAGE_VERSION}
BIND9_IMAGE_UNQUALIFIED=${BIND9_IMAGE_NAMESPACE}/${BIND9_IMAGE_NAME}:${BIND9_IMAGE_VERSION}

# BUILD CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/build
container-image/build:
	${CONTAINER_RUNTIME} build \
		--file Dockerfile \
		--no-cache \
		--pull \
		--tag ${BIND9_IMAGE_FULLY_QUALIFIED} \
		--tag ${BIND9_IMAGE_UNQUALIFIED} \
		.

# DELETE CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/delete
container-image/delete:
	- ${CONTAINER_RUNTIME} image rm ${BIND9_IMAGE_FULLY_QUALIFIED} ${BIND9_IMAGE_UNQUALIFIED}
	- ${CONTAINER_RUNTIME} image rm ${BASE_IMAGE_FULL}

# PUSH CONTAINER IMAGE
# ==============================================================================
PHONY+=container-image/push
container-image/push:
	echo ${BIND9_IMAGE_REGISTRY_PASSWORD} | ${CONTAINER_RUNTIME} login ${BIND9_IMAGE_REGISTRY_NAME} --username ${BIND9_IMAGE_REGISTRY_USER} --password-stdin
	${CONTAINER_RUNTIME} push ${BIND9_IMAGE_FULLY_QUALIFIED}

# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}