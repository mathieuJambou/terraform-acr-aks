#!/usr/bin/bash
set -euo pipefail

WORKING_DIRECTORY=${1}
PLATFORM=${2}
ENVIRONMENT_DIRECTORY=${3} #"dev"
REGION=${4}
cd ${WORKING_DIRECTORY}

# Set 755 on plugins folder
if [ -d "${WORKING_DIRECTORY}/${PLATFORM}/environments/${ENVIRONMENT}/${REGION}/.terraform/providers" ]; then
    chmod -R 755 ${WORKING_DIRECTORY}/${PLATFORM}/environments/${ENVIRONMENT}/${REGION}/.terraform/providers
fi
## Run Terraform Local
#terraform output -state=${BUILD_BUILDNUMBER}.tfplan -json

## Run Terraform on docker
docker run --rm --env ARM_CLIENT_ID \
            --env ARM_CLIENT_SECRET \
            --env ARM_SUBSCRIPTION_ID \
            --env ARM_TENANT_ID \
            --volume ${WORKING_DIRECTORY}:/go/src/terraform \
            --workdir /go/src/terraform/${PLATFORM}/environments/${ENVIRONMENT_DIRECTORY}/${REGION} \
            hashicorp/terraform:light \
            output -json > ./${PLATFORM}/environments/${ENVIRONMENT_DIRECTORY}/${REGION}/${BUILD_BUILDNUMBER}.output.json