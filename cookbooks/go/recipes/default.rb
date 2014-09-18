#
# vi: set ft=ruby :
#
# Cookbook name: go
# Recipe: default
#

package "golang" do
  action :install
end

# make sure that iptables allows for input/output on the port django will run on port 8080
bash 'iptables open port 8080' do
  code <<-"EOH"
    /sbin/iptables -I INPUT -p tcp --dport 8080 -m state --state NEW,ESTABLISHED -j ACCEPT
    /sbin/iptables -I OUTPUT -p tcp --dport 8080 -m state --state ESTABLISHED -j ACCEPT
    /sbin/service iptables save
  EOH
  action :run
  not_if "/sbin/iptables -L -v -n | /bin/grep \"tcp dpt:8080\""
end