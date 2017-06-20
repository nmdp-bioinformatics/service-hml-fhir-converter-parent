#!/usr/bin/env bash

SRC_PATH='pwd'

while getopts ":b:r:u:p:" opt; do
    case $opt in
        b) branch="$OPTARG"
        ;;
        r) repository="$OPTARG"
        ;;
        u) username="$OPTARG"
        ;;
        p) password="$OPTARG"
        ;;
        
    esac
done

if [ -z "$branch" ]; then
    branch="master"
fi

if [ -z "$username" ]; then
    echo "Github username?"
    read username
fi

if [ -z "$password" ]; then
    echo "Github password?"
    read password
fi

mkdir target/modules
mkdir target/modules/src
cd target/modules

curl -LJO https://github.com/nmdp-bioinformatics/$repository/archive/$branch.zip
unzip $repository-$branch.zip -d src/

cd src/$repository-$branch

sh install.sh -u $username -p $password -b $branch
