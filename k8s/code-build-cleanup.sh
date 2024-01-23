#!/bin/bash

# AWS CodeBuild project name
PROJECT_NAME="three-tier-app"
REGION="us-west-2"

# Number of builds to keep
KEEP_BUILD_COUNT=10

# Get a list of all builds for the project
BUILD_LIST=$(aws codebuild list-builds-for-project --project-name $PROJECT_NAME --sort-order DESCENDING --region $REGION --output json)
BUILD_LIST_IDS=($(echo "$BUILD_LIST" | jq -r '.ids[]'))

# Count the number of builds
BUILD_COUNT=$(echo "$BUILD_LIST" | jq -r '.ids | length')

# Calculate the number of builds to delete
DELETE_COUNT=$((BUILD_COUNT - KEEP_BUILD_COUNT))

echo "Number of builds to be deleted: $DELETE_COUNT"

if [ $DELETE_COUNT -gt 0 ]; then

    for ((i = ${#BUILD_LIST_IDS[@]}-1; i >= 0 && DELETE_COUNT > 0; i--)); do
        id="${BUILD_LIST_IDS[$i]}"
        aws codebuild batch-delete-builds --ids "$id" --region $REGION
        ((DELETE_COUNT--))
        echo "Deleted Build with id: $id"
    done
else
  echo "No old builds to delete. Keeping the most recent $KEEP_BUILD_COUNT builds."
fi
