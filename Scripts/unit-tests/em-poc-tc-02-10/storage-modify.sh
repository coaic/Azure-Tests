#!/bin/bash
#
. ../test-environment/environment.sh
KEY_SERVICES=bft
KEY_RESOURCES=sco
KEY_PERMISSIONS=acrdw
KEY_LIFETIME_MINUTES=15
KEY_EXPIRATION="+${KEY_LIFETIME_MINUTES} minutes"
STEP_DELAY=60
#
# Remove any files created in a previous run
#
rm *.txt
#
set -x
date
STORAGE_KEY=$(az storage account keys list --account-name ${STORAGE_ACCOUNT_NAME} --resource-group ${RESOURCE_GROUP_NAME}  --subscription "${SUBSCRIPTION}" --query "[0].value" --output tsv)
FILE_NAME=test-data.txt
#
let start_epoc=$(gdate +%s)
SAS_KEY=$(az storage  account generate-sas --account-name ${STORAGE_ACCOUNT_NAME} --services bft --resource-types sco --permissions acdrw  --expiry $(gdate -u -d "${KEY_EXPIRATION}" '+%Y-%m-%dT%H:%MZ') --subscription ${SUBSCRIPTION} --output tsv)
base64 /dev/urandom | head -c 10000000 > ${FILE_NAME}
#
sleep ${STEP_DELAY}
date
az storage container create --name ${CONTAINER_NAME} --account-key "${STORAGE_KEY}"  --account-name ${STORAGE_ACCOUNT_NAME}
#
##az storage blob upload --file ./${FILE_NAME} --container ${CONTAINER_NAME} --name ${FILE_NAME} --account-key "${STORAGE_KEY}"  --account-name ${STORAGE_ACCOUNT_NAME}
sleep ${STEP_DELAY}
date
az storage blob upload --file ./${FILE_NAME} --container ${CONTAINER_NAME} --name ${FILE_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
#
sleep ${STEP_DELAY}
date
az storage container list --account-key ${STORAGE_KEY} --account-name ${STORAGE_ACCOUNT_NAME}
#
sleep ${STEP_DELAY}
date
az storage blob list --container-name ${CONTAINER_NAME} --account-key ${STORAGE_KEY} --account-name ${STORAGE_ACCOUNT_NAME}
sleep ${STEP_DELAY}
date
az storage container show-permission --name ${CONTAINER_NAME} --account-key ${STORAGE_KEY} --account-name ${STORAGE_ACCOUNT_NAME}
#
sleep ${STEP_DELAY}
date
curl "https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${CONTAINER_NAME}/${FILE_NAME}?${SAS_KEY}" --output curl_download_${FILE_NAME}
sleep ${STEP_DELAY}
date
az storage blob download --file ./az_downloaded_${FILE_NAME} --container ${CONTAINER_NAME} --name ${FILE_NAME}  --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
# Remove blob and container for next run
#
sleep ${STEP_DELAY}
date
az storage blob exists --container ${CONTAINER_NAME} --name ${FILE_NAME}  --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
sleep ${STEP_DELAY}
date
az storage blob delete --container ${CONTAINER_NAME} --name ${FILE_NAME}  --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
sleep ${STEP_DELAY}
date
az storage blob exists --container ${CONTAINER_NAME} --name ${FILE_NAME}  --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
sleep ${STEP_DELAY}
date
az storage container exists --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
sleep ${STEP_DELAY}
date
az storage container delete --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
sleep ${STEP_DELAY}
date
az storage container exists --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
#
# Compute rough elapsed time in seconds
#
let end_epoc=$(gdate +%s)
let "elapsed_seconds = end_epoc - start_epoc"
set +x
echo "Elapsed seconds: ${elapsed_seconds}"
set -x
let "key_lifetime_seconds = ${KEY_LIFETIME_MINUTES} * 60"
let "remaining_sleep_time = key_lifetime_seconds - elapsed_seconds + 5"
sleep ${remaining_sleep_time}
#
# Verify key has expired; operation should report error
#
date
az storage container exists --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --sas-token "${SAS_KEY}"
