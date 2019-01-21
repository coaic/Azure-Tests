#!/bin/bash
#
az vm create -n MyLinuxVM -g MyResourceGroup --image ${LINUX_COMPLIANT_IMAGE} --ssh-key-value ~/.ssh/xxx_cloud_security_poc/azure-id_rsa
#
az disk delete -g MyResourceGroup --name $(az disk list -g MyResourceGroup  --query '[].name' -o tsv)
