#!/bin/bash

athena_directory=../athena-framework;

# Create temporary repository
git clone https://github.com/UCF/Athena-Framework.git temp-repo && cd temp-repo;
tags=$(git tag --list);

latest_version=$(printf "%s\n" "$tags" | sort -V | tail -n 1);

# Delete and recreate the directory
rm -rf $athena_directory;
mkdir $athena_directory;

# Create the version specific directories
for tag in $tags; do
    echo "Creating assets for ${tag}...";
    mkdir "${athena_directory}/${tag}/";
    git checkout $tag;
    cp -r ./dist/css "${athena_directory}/${tag}/";
    cp -r ./dist/js "${athena_directory}/${tag}/";
    cp -r ./dist/fonts "${athena_directory}/${tag}/";
done;

# Create and populate the latest directory
echo "Creating the latest directory...";
mkdir "${athena_directory}/latest/";
git checkout $latest_version;
cp -r ./dist/css "${athena_directory}/latest/";
cp -r ./dist/js "${athena_directory}/latest/";
cp -r ./dist/fonts "${athena_directory}/latest/";

cd ../;
rm -rf ./temp-repo;
