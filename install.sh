#!/usr/bin/env bash

curl -LJO https://raw.githubusercontent.com/nmdp-bioinformatics/util-swagger-codegen-models/master/Download.py
curl -LJO https://github.com/nmdp-bioinformatics/util-swagger-codegen-models/archive/master.zip

unzip util-swagger-codegen-models-master.zip
mv util-swagger-codegen-models-master/model_definitions model_definitions/
rm -rf util-swagger-codegen-models-master
rm -rf util-swagger-codegen-models-master.zip