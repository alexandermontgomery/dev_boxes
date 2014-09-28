#
# vi: set ft=ruby :
#
# Cookbook name: go
# Recipe: default
#

package "golang" do
  action :install
end

# Thanks you emil2k - https://github.com/emil2k/chef-go
# Create profile plugin file to export paths
template '/etc/profile.d/go.sh' do 
	source "go.sh.erb"
	mode 0644
	action :create
end

# make sure that iptables allows for input/output on the port go will run on port 8080
bash 'iptables open port 8080' do
  code <<-"EOH"
    /sbin/iptables -I INPUT -p tcp --dport 8080 -m state --state NEW,ESTABLISHED -j ACCEPT
    /sbin/iptables -I OUTPUT -p tcp --dport 8080 -m state --state ESTABLISHED -j ACCEPT
    /sbin/service iptables save
  EOH
  action :run
  not_if "/sbin/iptables -L -v -n | /bin/grep \"tcp dpt:8080\""
end