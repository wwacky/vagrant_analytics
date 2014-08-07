#
# Cookbook Name:: mecab
# Recipe:: cabocha-python
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cabocha_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/cabocha-#{node['cabocha']['version']}.tar.bz2"

bash "compile_mecab_python_source" do
	cwd ::File.dirname(cabocha_src_filepath)
	code <<-EOH
		cd cabocha-#{node['cabocha']['version']}/python &&
		#{node['python']['bin_path']}/python setup.py install
	EOH
end

execute 'ldconfig'

