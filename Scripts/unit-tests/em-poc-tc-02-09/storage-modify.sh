#!/bin/bash
#
. ../test-environment/environment.sh
#
set -x
STORAGE_KEY=$(az storage account keys list --account-name ${STORAGE_ACCOUNT_NAME} --resource-group ${RESOURCE_GROUP_NAME}  --subscription "${SUBSCRIPTION}" --query "[0].value" --output tsv)
FILE_NAME=test-data.txt
base64 /dev/urandom | head -c 10000000 > ${FILE_NAME}
#
az storage container create --name ${CONTAINER_NAME} --account-key "${STORAGE_KEY}"  --account-name ${STORAGE_ACCOUNT_NAME}
#
az storage blob upload --file ./${FILE_NAME} --container ${CONTAINER_NAME} --name ${FILE_NAME} --account-key "${STORAGE_KEY}"  --account-name ${STORAGE_ACCOUNT_NAME}
#
#
az storage container list --account-key ${STORAGE_KEY} --account-name ${STORAGE_ACCOUNT_NAME}
#
az storage blob list --container-name ${CONTAINER_NAME} --account-key ${STORAGE_KEY} --account-name ${STORAGE_ACCOUNT_NAME}
#
az storage blob download --file ./downloaded_${FILE_NAME} --container ${CONTAINER_NAME} --name ${FILE_NAME} --account-key "${STORAGE_KEY}"  --account-name ${STORAGE_ACCOUNT_NAME}
