# # encoding: utf-8

# Inspec test for recipe tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe port(8080) do
  it { should be_listening }
end

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe group('tomcat') do
  it { should exist }
end

describe user('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('home') { should eq '/opt/tomcat' }
end

describe file('/opt/tomcat') do
  it { should exist }
  its('type') { should cmp 'directory' }
end

describe file('/opt/tomcat/conf') do
  it { should exist }
  its('type') { should cmp 'directory' }
end

%w[webapps work temp logs].each do |path|
  describe file("/opt/tomcat/#{path}") do
    it { should exist }
    its('type') { should cmp 'directory' }
    its('owner') { should eq 'tomcat' }
  end
end

describe systemd_service('tomcat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
