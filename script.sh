#!/bin/bash

# FETCH GITHUB REPOSITORY
githubRepositoryName="restaurant"
gitRepositoryLink="https://github.com/groupe-epsi-work/restaurant.git"
gitRepositoryBranch="sofiane_nasri"

if [ -d "./$githubRepositoryName" ]; then
    git -C "./$githubRepositoryName" restore .
    git -C "./$githubRepositoryName" pull origin "$gitRepositoryBranch"
else 
    git clone "$gitRepositoryLink"
fi

# MOVE TO GIT BRANCH
git -C "./$githubRepositoryName" checkout "$gitRepositoryBranch"

# RUN BUILD
mvn -f "./$githubRepositoryName" install -DskipTests

# RUN TESTS
mvn -f "./$githubRepositoryName" test

## KEEP GENERATED PROPERTIES
applicationPropertiesLocation="./restaurant/target/classes/application.properties"
tempFolderLocation="./temp"

if [ -d "./$tempFolderLocation" ]; then
    echo "TEMP FOLDER ALREADY EXIST"
else 
    mkdir "$tempFolderLocation"
fi

rm -rf "$tempFolderLocation/*"
cp "$applicationPropertiesLocation" "$tempFolderLocation/"

## MOVE PREVIOUS APPLICATION PROPERTIES TO BUILD LOCATION
buildPropertiesFolderLocation="./restaurant/target/classes/"

rm -f "$applicationPropertiesLocation"
cp "$tempFolderLocation/application.properties" "$buildPropertiesFolderLocation"

## DEPLOY SPRING BOOT APP
applicationJarLocation="./restaurant/target/exercice-0.0.1-SNAPSHOT.jar"

java -jar "$applicationJarLocation"




