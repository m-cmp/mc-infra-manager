#!/bin/bash

# Initialize and update submodule if not already done
if [ ! -d "cb-tumblebug/.git" ]; then
  echo "Initializing and updating CB-Tumblebug submodule..."
  git submodule update --init --recursive cb-tumblebug
  if [ $? -ne 0 ]; then
    echo "Error: Failed to initialize submodule"
    exit 1
  fi
fi

cd cb-tumblebug || { echo "Error: Failed to enter cb-tumblebug directory."; exit 1; }

# Fetch all tags from the remote repository
git fetch --tags

# Sort and display the list of available tags and get user input
echo "[Available tags in CB-Tumblebug]"
git tag -l | sort -V
echo "[Select a tag to checkout]"
read -r TARGET_TAG

# Checkout to the tag specified by the user
git checkout tags/$TARGET_TAG
if [ $? -ne 0 ]; then
  echo "Error: Failed to checkout tag $TARGET_TAG"
  exit 1
fi

# Navigate back to the parent directory
cd ..

# Stage the changes
git add -u

# Create a commit
git commit -m "Update Submodule CB-Tumblebug $TARGET_TAG"

echo "CB-Tumblebug successfully updated to $TARGET_TAG"
echo "ToDo: git log"
echo "ToDo: git push origin"

