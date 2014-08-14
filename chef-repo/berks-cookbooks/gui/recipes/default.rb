#
# Cookbook Name:: gui
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "devtools" do
  user "root"
  command 'yum -y groupinstall "X Window System" "Desktop" "General Purpose Desktop"'
  action :run
end

execute "gui_set" do
  user "root"
  command 'sed -i "s/id:3:initdefault:/id:5:initdefault:/g" /etc/inittab'
  action :run
end

package 'firefox'
