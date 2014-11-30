#
# vi: set ft=ruby :
#
# Cookbook name: mongo_simple
# Recipe: default
#

package "nginx" do
  action :install
end

template "/etc/nginx/conf.d/default.conf" do
    source "default.conf.erb"   
    owner "root"
    group "root"     
end

# make sure that iptables allows for input/output on the port go will run on port 80
bash 'iptables open port 80' do
  code <<-"EOH"
    /sbin/iptables -I INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
    /sbin/iptables -I OUTPUT -p tcp --dport 80 -m state --state ESTABLISHED -j ACCEPT
    /sbin/service iptables save
  EOH
  action :run
  not_if "/sbin/iptables -L -v -n | /bin/grep \"tcp dpt:80\""
end

service "nginx" do
  action [:stop, :start]
end