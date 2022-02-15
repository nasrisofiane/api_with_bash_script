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


