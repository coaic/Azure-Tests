#!/bin/bash
#
. ../test-environment/environment.sh
set -x
az group create --name ${RESOURCE_GROUP_NAME} \
                --location ${LOCATION} \
                --subscription "${SUBSCRIPTION}"
#
az storage account create --name ${STORAGE_ACCOUNT_NAME} \
                           --resource-group ${RESOURCE_GROUP_NAME} \
                           --encryption-services blob file \
                           --https-only \
                           --location ${LOCATION} \
                           --subscription "${SUBSCRIPTION}"
#
az network vnet create --resource-group ${RESOURCE_GROUP_NAME} \
                       --name ${VNET_NAME} \
                       --address-prefix ${VNET_ADDRESS_PREFIX} \
                       --subnet-name ${VNET_SUBNET_NAME_SUBN1} \
                       --subnet-prefix ${VNET_ADDRESS_PREFIX_SUBN1} \
                       --location ${LOCATION} \
                       --subscription "${SUBSCRIPTION}"
#
az network vnet subnet create --resource-group ${RESOURCE_GROUP_NAME} \
                              --vnet-name ${VNET_NAME} \
                              --name ${VNET_SUBNET_NAME_SUBN2} \
                              --address-prefix ${VNET_ADDRESS_PREFIX_SUBN2} \
                              --subscription "${SUBSCRIPTION}"
#
az network nsg create --resource-group ${RESOURCE_GROUP_NAME} \
                      --name ${VNET_NETWORK_SECURITY_GROUP} \
                      --location ${LOCATION} \
                      --subscription "${SUBSCRIPTION}"
#
az network nic create --resource-group ${RESOURCE_GROUP_NAME} \
                      --name ${VNET_NIC_NAME_NIC1} \
                      --vnet-name ${VNET_NAME} \
                      --subnet ${VNET_SUBNET_NAME_SUBN1} \
                      --network-security-group ${VNET_NETWORK_SECURITY_GROUP} \
                      --location ${LOCATION} \
                      --subscription "${SUBSCRIPTION}"
