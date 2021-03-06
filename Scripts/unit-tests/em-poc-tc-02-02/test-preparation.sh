#!/bin/bash
#
. ../test-environment/environment.sh
set -x
az group create --name ${RESOURCE_GROUP_NAME} \
                --location ${NON_COMPLIANT_LOCATION} \
                --subscription "${SUBSCRIPTION}"
#
az storage account create --name ${STORAGE_ACCOUNT_NAME} \
                           --resource-group ${RESOURCE_GROUP_NAME} \
                           --encryption-services blob file \
                           --https-only \
                           --location ${NON_COMPLIANT_LOCATION} \
                           --subscription "${SUBSCRIPTION}"
