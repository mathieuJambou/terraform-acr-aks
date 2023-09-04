#!/usr/bin/bash
#!/usr/bin/bash
set -euo pipefail

WORKING_DIRECTORY=${1}
PLATFORM=${2}
ENVIRONMENT=${3} #"dev"
REGION=${4}
VARIABLE_FILE=${5}

cd ${WORKING_DIRECTORY}

if [[ $ENVIRONMENT =~ "dr" ]];
then
    FORTIGATE_LICENSE_FILENAME="fortigate-dr-license"
else
    FORTIGATE_LICENSE_FILENAME="fortigate-license"
fi

# Set 755 on plugins folder
if [ -d "${WORKING_DIRECTORY}/${PLATFORM}/environments/${ENVIRONMENT}/${REGION}/.terraform/providers" ]; then
    chmod -R 755 ${WORKING_DIRECTORY}/${PLATFORM}/environments/${ENVIRONMENT}/${REGION}/.terraform/providers
fi

## Run Terraform Local
#terraform destroy -force

## Run Terraform in Docker
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
            destroy -var-file=${VARIABLE_FILE} -force 