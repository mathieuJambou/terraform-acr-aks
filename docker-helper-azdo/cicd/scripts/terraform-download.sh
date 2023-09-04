#!/usr/bin/env bash
set -euo pipefail

# Assuming Azure DevOps agents get the proper terraform version
#
#curl -SL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" --output terraform.zip
#echo "${TERRAFORM_DOWNLOAD_SHA} terraform.zip" | sha256sum -c -
#unzip "terraform.zip" -v
#sudo mv terraform /usr/local/bin

#terraform --version

#rm terraform.zip
docker rmi --force hashicorp/terraform:light
docker run --rm hashicorp/terraform:light --version