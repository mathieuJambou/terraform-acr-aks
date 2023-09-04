#!/usr/bin/bash

WORKING_DIRECTORY=${1}
cd ${WORKING_DIRECTORY}

STORAGE_ACCOUNT_NAME=${2} #""
CONTAINER_NAME=${3} #"terraform"
PLATFORM=${4}
ENVIRONMENT_DIRECTORY=${5} #"dev"
REGION=${6}
BLOB_NAME="${PLATFORM}/${ENVIRONMENT_DIRECTORY}/${REGION}/output/${ENVIRONMENT_DIRECTORY}.${PLATFORM}.${BUILD_BUILDNUMBER}.output.json"
SOURCE_FILE="./${BUILD_BUILDNUMBER}.output.json" #"./output.json"

### For Troubleshooting purpose. Exposing secrets in AzDO Logs will return *** .
#
#echo "${WORKING_DIRECTORY}"
#echo "${STORAGE_ACCOUNT_NAME}"
#echo "${CONTAINER_NAME}"
#echo "${BLOB_NAME}"
#echo "${SOURCE_FILE}"

#ls -al

#echo ""
#echo "az storage blob upload --account-key ${SA_KEY} --account-name ${STORAGE_ACCOUNT_NAME} --container-name ${CONTAINER_NAME} --name '${BLOB_NAME}' --file '${SOURCE_FILE}'"
#
### End of Troubleshooting section.

docker run --rm --env AZURE_STORAGE_KEY \
            --volume ${WORKING_DIRECTORY}:/src/terraform \
            --workdir /src/terraform/${PLATFORM}/environments/${ENVIRONMENT_DIRECTORY}/${REGION} \
            mcr.microsoft.com/azure-cli \
            az storage blob upload --account-name ${STORAGE_ACCOUNT_NAME} --container-name ${CONTAINER_NAME} --name ${BLOB_NAME} --file ${SOURCE_FILE}