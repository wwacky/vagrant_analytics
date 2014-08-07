#
# Cookbook Name:: mecab
# Recipe:: cabocha
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#install CRF++
include_recipe 'mecab::crf'

cabocha_src_url = "https://cabocha.googlecode.com/files/cabocha-#{node['cabocha']['version']}.tar.bz2"
cabocha_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/cabocha-#{node['cabocha']['version']}.tar.bz2"

#download src
remote_file cabocha_src_filepath do
	source cabocha_src_url
	checksum node['cabocha']['checksum']
	backup false
end

#setting
template "libpath_for_cabocha.conf" do
	path "/etc/ld.so.conf.d/libpath_for_cabocha.conf"
	source "libpath_for_cabocha.conf.erb"
	owner "root"
	group "root"
	mode 0640
#	:mecab_lib => node['mecab']['lib']
end

execute 'ldconfig'



#compile
bash "compile_cabocha_source" do
	cwd ::File.dirname(cabocha_src_filepath)
	code <<-EOH
		bzip2 -dc cabocha-#{node['cabocha']['version']}.tar.bz2 | tar xvf - &&
		cd cabocha-#{node['cabocha']['version']} &&
		./configure --with-mecab-config=#{node['mecab']['mecab_config_path']} --with-charset=UTF8 &&
		make &&
		make check &&
		make install
	EOH
end

