#!/bin/bash

# FETCH GITHUB REPOSITORY
githubRepositoryName="restaurant"
gitRepositoryLink="https://github.com/groupe-epsi-work/restaurant.git"
gitRepositoryBranch="sofiane_nasri"

if [ -d "./$githubRepositoryName" ]; then
    git -C "./$githubRepositoryName" pull origin "$gitRepositoryBranch"
else 
    git clone "$gitRepositoryLink"
fi

# MOVE TO GIT BRANCH
git -C "./$githubRepositoryName" checkout "$gitRepositoryBranch"

# RUN BUILD
mvn install -DskipTests

# RUN TESTS
mvn test

## KEEP PREVIOUS PROPERTIES
applicationPropertiesLocation="./restaurant/target/classes/application.properties"
tempFolderLocation="./temp"

rm -rf "$tempFolderLocation/*"
cp "$applicationPropertiesLocation" "$tempFolderLocation/"

## DEPLOY SPRING BOOT APP
applicationJarLocation="./restaurant/target/exercice-0.0.1-SNAPSHOT.jar"

java -jar "$applicationJarLocation"




