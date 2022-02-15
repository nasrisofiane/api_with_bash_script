#!/bin/bash

# FETCH GITHUB REPOSITORY
githubRepositoryName="restaurant"
gitRepositoryLink="https://github.com/groupe-epsi-work/restaurant.git"
gitRepositoryBranch="sofiane_nasri"

if [ -d "./$githubRepositoryName" ]; then
    cd "./$githubRepositoryName"
    git pull origin "$gitRepositoryBranch"
    cd ../
else 
    git clone "$gitRepositoryLink"
fi

# MOVE TO GIT BRANCH
cd "./$githubRepositoryName"
git checkout "$gitRepositoryBranch"

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

java -jar 




