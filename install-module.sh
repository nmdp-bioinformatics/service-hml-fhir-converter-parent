#!/usr/bin/env bash

SRC_PATH=$(pwd)

while getopts ":r:m:p:b:" opt; do
    case $opt in
        r) repository="$OPTARG"
        ;;
        m) model_path="$OPTARG"
        ;;
        p) packages="$OPTARG"
        ;;
        b) branch="$OPTARG"
        ;;
    esac
done

if [ -z "$branch" ]; then
    branch="master"
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

cp -a $MODULE_SRC/$repository-$branch/ $SRC_PATH/$repository/
rm -rf $MODULE_SRC/$repository-$branch
rm -rf $SRC_PATH/$repository-$branch.zip
cd $SRC_PATH/$repository
cp $SRC_PATH/Download.py $SRC_PATH/$repository/Download.py

sh install.sh -m $model_path -y $SRC_PATH/$repository/Download.py -p $packages

rm -f $MODULE_SRC/$repository/Download.py
