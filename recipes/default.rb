#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
  home '/opt/tomcat'
end

# Tomcat http://apache.mirrors.hoobly.com/tomcat/tomcat-8/v8.0.51/bin/apache-tomcat-8.0.51.tar.gz

remote_file 'apache-tomcat-8.0.51.tar.gz' do
  source 'http://apache.mirrors.hoobly.com/tomcat/tomcat-8/v8.0.51/bin/apache-tomcat-8.0.51.tar.gz'
end

directory '/opt/tomcat' do
  # action :create
end

# TODO: NOT DESIRED STATE
execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
execute 'cd /opt/tomcat'
execute 'chgrp -R tomcat /opt/tomcat'
execute 'chmod -R g+r /opt/tomcat/conf'
execute 'chmod g+x /opt/tomcat/conf'
execute 'chown -R tomcat /opt/tomcat/webapps/'
execute 'chown -R tomcat /opt/tomcat/work/'
execute 'chown -R tomcat /opt/tomcat/temp/'
execute 'chown -R tomcat /opt/tomcat/logs/'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

# TODO: NOT DESIRED STATE
execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end
