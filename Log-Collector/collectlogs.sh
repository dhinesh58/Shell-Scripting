#####################################
#Author: Dhinesh R
#Team : Infra Team 
#Description : This Script for upload a jenkins logs to azure blob storage account
########################################################
#!/bin/bash
set -x
#Variables 
AZURE_STORAGE_ACCOUNT="collectlogs096"
AZURE_STORAGE_CONTAINER="jenkins"
AZURE_STORAGE_KEY="1EXJCjnij3du+MbWZO0xcQDna5fXasqUU6WkKAN2oqfR4//OKGuAeszyYfqPURgSGqsCPP+oJHJu+ASt0Gl2vQ=="
JEKINS_DIR="/var/lib/jenkins/jobs/Pipe/builds/1/build.xml"
BLOB_NAME="logs/$(date +%Y-%m-%d_%H-%M-%S).log"

# Install Azure CLI if not already installed
if ! command -v az &> /dev/null
then
    echo "Azure CLI not found, installing..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

# Upload the log file to Azure Blob Storage
az storage blob upload --account-name $AZURE_STORAGE_ACCOUNT --container-name $AZURE_STORAGE_CONTAINER --name $BLOB_NAME --file $JEKINS_DIR --account-key $AZURE_STORAGE_KEY

echo "Log file uploaded to Azure Blob Storage as $BLOB_NAME"



