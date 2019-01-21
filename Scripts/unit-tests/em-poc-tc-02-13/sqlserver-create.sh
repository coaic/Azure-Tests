#!/bin/bash
#
. ../test-environment/environment.sh
#
set -x
date
az sql server create \
	--name ${SQLSERVER_NAME} \
	--resource-group ${RESOURCE_GROUP_NAME} \
	--location ${LOCATION}  \
  --subscription ${SUBSCRIPTION} \
	--admin-user ${WIN_ADMIN_USER} \
	--admin-password ${WIN_ADMIN_PASSWORD} 
#
date
az sql server firewall-rule create \
	--resource-group ${RESOURCE_GROUP_NAME} \
	--server ${SQLSERVER_NAME} \
  --subscription ${SUBSCRIPTION} \
	--name ${SQLSERVER_FW_RULE_NAME} \
	--start-ip-address ${SQLSERVER_START_IP} \
	--end-ip-address ${SQLSERVER_END_IP}
#
date
az sql db create \
	--resource-group ${RESOURCE_GROUP_NAME} \
	--server ${SQLSERVER_NAME} \
  --subscription ${SUBSCRIPTION} \
	--name ${SQLSERVER_DATABASE_NAME} \
	--sample-name AdventureWorksLT 
