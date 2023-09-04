#!/usr/bin/bash
set -euo pipefail

WORKING_DIRECTORY=${1}
PLATFORM=${2}
ENVIRONMENT_DIRECTORY=${3} #"dev"
REGION=${4}
cd ${WORKING_DIRECTORY}

## Run Terraform Local
#terraform init -input=false

## Run Terraform in Docker
docker run --rm --env ARM_CLIENT_ID \
            --env ARM_CLIENT_SECRET \
            --env ARM_SUBSCRIPTION_ID \
            --env ARM_TENANT_ID \
            --volume ${WORKING_DIRECTORY}:/go/src/terraform \
            --workdir /go/src/terraform/${PLATFORM}/environments/${ENVIRONMENT_DIRECTORY}/${REGION} \
            --user `id -u`:`id -g` \
            hashicorp/terraform:light \
            init -upgrade -input=false