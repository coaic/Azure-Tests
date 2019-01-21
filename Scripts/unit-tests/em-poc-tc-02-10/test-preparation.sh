#!/bin/bash
#
. ../test-environment/environment.sh
set -x
date
az group create --name ${RESOURCE_GROUP_NAME} \
                --location ${LOCATION} \
                --subscription "${SUBSCRIPTION}"
#
sleep 120
date
az storage account create --name ${STORAGE_ACCOUNT_NAME} \
                           --resource-group ${RESOURCE_GROUP_NAME} \
                           --encryption-services blob file table \
                           --https-only \
                           --location ${LOCATION} \
                           --subscription "${SUBSCRIPTION}"
#
