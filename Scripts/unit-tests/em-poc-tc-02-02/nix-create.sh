#!/bin/bash
#
. ../test-environment/environment.sh
#
set -x
az vm create -n ${VM_NIX_NAME} \
  -g ${RESOURCE_GROUP_NAME} \
  --image ${LINUX_COMPLIANT_IMAGE} \
  --size ${VM_NIX_SIZE} \
  --boot-diagnostics-storage ${STORAGE_ACCOUNT_NAME} \
  --ssh-key-value ~/.ssh/xxx_cloud_security_poc/azure-id_rsa.pub \
  --location ${NON_COMPLIANT_LOCATION} \
  --subscription "${SUBSCRIPTION}"
