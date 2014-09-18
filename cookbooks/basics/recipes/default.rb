# vi: set ft=ruby :
#
# Cookbook name: basics
# Recipe: default
#

# This must be done via bash because otherwise Chef makes yum think we are trying to install a package.
# The yum_package resource fails for the same reason as generic package.
bash "install EPEL repo" do
  code <<-"EOH"
    /usr/bin/yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    /usr/bin/yum groupinstall "Development tools"
  EOH
  action :run
  not_if "/bin/ls /etc/yum.repos.d/ | grep epel.repo"
end

package "zlib" do
  action :install
end

package "zlib-devel" do
  action :install
end

package "strace" do
  action :install
end

package "lsof" do
  action :install
end