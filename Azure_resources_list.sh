#!/bin/bash
set -x 
####################################################################################
# Script to automate the process of listing all the resources in azure account
# Author : Dhinesh/ Infra Team 
# Version : V0.0.1
# Date : 16-Aug-2024
#  List the azure resources
# listing azure resources in specfic resource group.
List_resources_in_group() {
    resource_group=$1
    echo "listing resources in specfic resource group"
    az resource list --resource-group $resource_group --output table
}
# listing all azure resources across all resource groups.
list_all_resources(){
    echo " listing all azure resources across all resource group"
    az resource list --output table
}
# Check if a resource group name was passed as an argument
if [ -z "$1"]; then
echo " No resource group specified then listing all resources"
list_all_resources
else
resource_group=$1
List_resources_in_group $resource_group
fi   
 
