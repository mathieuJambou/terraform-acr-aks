#!/usr/bin/bash
set -euo pipefail

WORKING_DIRECTORY=${1}
PLATFORM=${2}
ENVIRONMENT=${3} #"dev"
REGION=${4}
VARIABLE_FILE=${5}

cd ${WORKING_DIRECTORY}

## Find all available main.tf
# find . -type f -iname "main.tf";

## Run Terraform Local
#terraform plan -out ${BUILD_BUILDNUMBER}.tfplan -input=false

## Run Terraform on Docker
docker run --rm --env ARM_CLIENT_ID \
            --env ARM_CLIENT_SECRET \
            --env ARM_SUBSCRIPTION_ID \
            --env ARM_TENANT_ID \
            --env TF_VAR_region \
            --env TF_VAR_fingerprint \
            --env TF_VAR_tenancy_ocid \
            --env TF_VAR_user_ocid \
            --env TF_VAR_user \
            --env TF_VAR_password \
            --env TF_VAR_azdo_pat_token \
            --volume ${WORKING_DIRECTORY}:/go/src/terraform \
            --workdir /go/src/terraform/${PLATFORM}/environments/${ENVIRONMENT}/${REGION} \
            hashicorp/terraform:light \
            plan -var-file=${VARIABLE_FILE} -out ${BUILD_BUILDNUMBER}.tfplan -input=false | tee ./${PLATFORM}/environments/${ENVIRONMENT}/${REGION}/${BUILD_BUILDNUMBER}.planreport