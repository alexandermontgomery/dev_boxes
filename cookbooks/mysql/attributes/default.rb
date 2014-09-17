# default root password
default[:mysql][:server_root_password] = 'r00tp@ssw0rd'

default[:mysql][:user_list] = [{ :username => 'dev', :password => 'dev'}]

default[:mysql][:databases] = [{:name => 'dev'}]
