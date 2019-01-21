#!/bin/bash
#
. ../test-environment/environment.sh
#
set -x
az vm create -n ${VM_WIN_NAME} \
  -g ${RESOURCE_GROUP_NAME} \
  --image ${WINDOWS_COMPLIANT_IMAGE} \
  --admin-username ${WIN_ADMIN_USER} \
  --admin-password ${WIN_ADMIN_PASSWORD} \
  --size ${VM_WIN_SIZE} \
  --nics ${VNET_NIC_NAME_NIC1} ${VNET_NIC_NAME_NIC2} \
  --boot-diagnostics-storage ${STORAGE_ACCOUNT_NAME} \
  --location ${LOCATION} \
  --subscription "${SUBSCRIPTION}"
