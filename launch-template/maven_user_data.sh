#!/bin/sh

sudo apt-get update
git clone https://github.com/uyadav585/sample_java_loginapp.git

cd sample_java_loginapp/

mvn clean install deploy -s settings.xml