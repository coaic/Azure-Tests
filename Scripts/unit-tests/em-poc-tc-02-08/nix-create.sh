#!/bin/bash
#
. ../test-environment/environment.sh
#
set -x
az vm create -n ${VM_NIX_NAME} \
  -g ${RESOURCE_GROUP_NAME} \
  --image ${LINUX_NON_COMPLIANT_IMAGE} \
  --size ${VM_NIX_SIZE} \
  --nics ${VNET_NIC_NAME_NIC1} \
  --boot-diagnostics-storage ${STORAGE_ACCOUNT_NAME} \
  --ssh-key-value ~/.ssh/xxx_cloud_security_poc/azure-id_rsa.pub \
  --location ${LOCATION} \
  --subscription "${SUBSCRIPTION}"
