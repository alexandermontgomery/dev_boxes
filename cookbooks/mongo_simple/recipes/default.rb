#
# vi: set ft=ruby :
#
# Cookbook name: mongo_simple
# Recipe: default
#

template "/etc/yum.repos.d/mongodb.repo" do
    source "mongodb.repo.erb"   
    owner "root"
    group "root"     
end

package "mongodb-org" do
  action :install
end

bash 'iptables open port 27017' do
  code <<-"EOH"
  	semanage port -a -t mongodb_port_t -p tcp 27017
    /sbin/iptables -I INPUT -p tcp --dport 27017 -m state --state NEW,ESTABLISHED -j ACCEPT
    /sbin/iptables -I OUTPUT -p tcp --dport 27017 -m state --state ESTABLISHED -j ACCEPT
    /sbin/service iptables save
  EOH
  action :run
  not_if "/sbin/iptables -L -v -n | /bin/grep \"tcp dpt:27017\""
end