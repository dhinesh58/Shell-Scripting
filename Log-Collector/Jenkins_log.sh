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
JENKINS_DIR="/var/lib/jenkins/"
BLOB_NAME="logs/$(date +%Y-%m-%d_%H-%M-%S).log"
DATE=$(date +%Y-%m-%d)

# Install Azure CLI if not already installed
if ! command -v az &> /dev/null
then
    echo "Azure CLI not found, installing..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

# Iterate through all job directories
for job_dir in "$JENKINS_DIR/jobs/"*/; do
    job_name=$(basename "$job_dir")
    
# Iterate through build directories for the job
    for build_dir in "$job_dir/builds/"*/; do
        # Get build number and log file path
        build_number=$(basename "$build_dir")
        log_file="$build_dir/log"

# Check if log file exists and was created today
        if [ -f "$log_file" ] && [ "$(date -r "$log_file" +%Y-%m-%d)" == "$DATE" ]; then
            # Upload log file to S3 with the build number as the filename
            azcopy copy "$log_file" "https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/$AZURE_STORAGE_CONTAINER/$job_name-$build_number.log

            if [ $? -eq 0 ]; then
                echo "Uploaded: $job_name/$build_number to "azcopy copy "$log_file" "https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/$AZURE_STORAGE_CONTAINER/$job_name-$build_number.log
            else
                echo "Failed to upload: $job_name/$build_number"
            fi
        fi
    done
done
