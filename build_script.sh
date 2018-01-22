#!/bin/bash

echo "Please enter branch for core app"  #branch or tag from which build for core app is to be taken
read core
echo "please enter branch  for plugins"  #Branch or taf from wchich build for plugins is to be taken
read plugin
echo "Please enter tag for build"        # Tag version for current build 
read tag

build_home=     #Location where repositories are cloned 
Plugin_dir="$build_home/plugin_build"
plugin_build="./build/libs"
bower_component_path="$build_home/openspecimen/www/bower_components/"
bower_component="./src/main/webapp/bower_components"
node_module_path="$build_home/openspecimen/www/node_modules/"
node_module="./src/main/webapp/node_modules"
external_module_path="$build_home/openspecimen/www/external_components"
external_module="./src/main/webapp/external_components"

build()   #A comman steps need to create build for plugins 
{
git checkout $plugin
git pull
git tag -a $tag -m "OS  plugin release $tag"
ln -s $bower_component_path $bower_component
ln -s $node_module_path $node_module
ln -s $external_module_path $external_module
gradle clean
gradle build
cp $plugin_build/*.jar $Plugin_dir
git push origin $tag
cd $build_home
}

rm -rf $Plugin_dir/*
cd $build_home
rm -rf  ./openspecimen/
git clone --depth 10 https://<username>:<password>@github.com/krishagni/openspecimen.git
cd ./openspecimen/

git checkout $core
git pull
git tag -a $tag -m "OS release $tag"
git checkout $tag
cd ./www/
npm install
bower install
cd  $build_home/openspecimen/
gradle clean
gradle build
git push origin $tag

cd $build_home
rm -rf ./os-extras/
git clone https://<username>:<password>@bitbucket.org/krishagni/os-extras.git
cd ./os-extras/
build

rm -rf ./dashboard/
git clone https://<username>:<password>@bitbucket.org/krishagni/dashboard.git
cd ./dashboard/
build
rm -rf ./sde/
git clone https://<username>:<password>@bitbucket.org/krishagni/sde.git
cd ./sde/
build
rm -rf ./rde/  
git clone https://<username>:<password>@bitbucket.org/krishagni/rde.git
cd ./rde/
build

rm -rf ./specimen-catalog/
git clone https://<username>:<password>@bitbucket.org/krishagni/specimen-catalog.git
cd ./specimen-catalog/
build

rm -rf ./specimen-array/
git clone https://<username>:<password>@bitbucket.org/krishagni/specimen-array.git
cd ./specimen-array/
build
rm -rf ./specimen-gel/
git clone https://<username>:<password>@bitbucket.org/krishagni/specimen-gel.git
cd ./specimen-gel/
build
rm -rf ./specimen-request/
git clone https://<username>:<password>@bitbucket.org/krishagni/specimen-request.git
cd ./specimen-request/
build

rm -rf ./distribution-invoicing/
git clone https://<username>:<password>@bitbucket.org/krishagni/distribution-invoicing.git
cd ./distribution-invoicing/

git clone https://<username>:<password>@bitbucket.org/krishagni/os-installer.git
cd ./os-installer/
git checkout master
git pull
cp ../gradle.properties .
gradle clean
gradle generate_packages
mv build/dist/openspecimen_$tag*.zip  /path/to/sftp/server/
echo "Build is created" | mail -s "Build status: Build is created<EOM>"

