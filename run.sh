#!/usr/bin/env bash

SRC_PATH=$(pwd)

while getopts ":e:" opt; do
    case $opt in
        e) executable="$OPTARG"
        ;;
    esac
done

if [ -z "executable" ]; then
    executable=$SRC_PATH/service-hml-fhir-converter-api.jar
fi

java -jar $executable
