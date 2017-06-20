#!/usr/bin/env bash

SRC_PATH=$(pwd)

while getopts ":b:r:u:p:m:" opt; do
    case $opt in
        b) branch="$OPTARG"
        ;;
        r) repository="$OPTARG"
        ;;
        u) username="$OPTARG"
        ;;
        p) password="$OPTARG"
        ;;
        m) model_path="$OPTARG"
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

TARGET_DIR=$SRC_PATH/target
MODULE_ARCHIVE=$TARGET_DIR/modules
MODULE_SRC=$MODULE_ARCHIVE/src

mkdir $TARGET_DIR
mkdir $MODULE_ARCHIVE
mkdir $MODULE_SRC
cd $MODULE_ARCHIVE

curl -LJO https://github.com/nmdp-bioinformatics/$repository/archive/$branch.zip
unzip $repository-$branch.zip -d $MODULE_SRC/

cp -a $MODULE_SRC/$repository-$branch/ $MODULE_SRC/$repository/
rm -rf $MODULE_SRC/$repository-$branch
rm -rf $SRC_PATH/$repository-$branch.zip
cd $MODULE_SRC/$repository
cp $SRC_PATH/Download.py $MODULE_SRC/$repository/Download.py

sh install.sh -u $username -p $password -b $branch -m $model_path -y $SRC_PATH/target/modules/src/$repository/Download.py

rm -f $MODULE_SRC/$repository/Download.py
