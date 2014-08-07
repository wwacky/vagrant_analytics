#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#package 'vim'

%w{
	vim
	git
	unzip
}.each do |pkgname|
	package pkgname do
		action :install
	end
end
