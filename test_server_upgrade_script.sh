#!/bin/bash
os_home=  #location of OpenSpecimen  
installable=$os_home/install
webapps=$os_home/tomcat-as/webapps
new_plugins=$os_home/install/plugins
os_plugins=$os_home/ <> #OS plugin directory
os_data=$os_home/<>  #OS data directory


cd $installable
package=`ls -1`
unzip $package >/dev/null
mkdir war
cp openspecimen.war war
cd war/
unzip openspecimen.war >/dev/null
rm openspecimen.war
sed -ie  "s,app.data_dir=\<app_data_dir\>,app.data_dir=$os_data,g" WEB-INF/classes/application.properties
sed -ie  "s,plugin.dir=\<path-to-directory-containing-plugin-jars\>,plugin.dir=$os_plugins,g" WEB-INF/classes/application.properties
jar -cvf os-test.war * > /dev/null

cp $new_plugins/* $os_plugins/
cp  $installable/war/os-test.war $webapps

sleep 200

    curl -I   > http://test.openspecimen.org/os-test/ /tmp/output1.txt
    var1=$(head -1 /tmp/output1.txt | awk '{print $2}')
    var2=200

      if [ $var1 -eq $var2 ]
         then
           echo "Test Server is up"  | mail -s "OS-TEST: Server Status" paresh@krishagni.com
          else
          echo "Test Server is down " | mail -s "ALERT OS-TEST :Server Status" parehs@krishagni.com
     fi 
