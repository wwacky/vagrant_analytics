#
# Cookbook Name:: mecab
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#ImportError: libmecab.so.2回避
#templateの使い方がよくわからなかったのでとりあえず
#bash "setting" do
#	code <<-EOH
#		echo "/usr/local/lib" >> /etc/ld.so.conf
#	EOH
#end

template "ld.so.conf" do
	path "/etc/ld.so.conf"
	source "ld.so.conf.erb"
	owner "root"
	group "root"
	mode 0640
#	:mecab_lib => node['mecab']['lib']
end

execute 'ldconfig'


mecab_python_src_url = "https://mecab.googlecode.com/files/mecab-python-#{node['mecab']['version']}.tar.gz"
mecab_python_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/mecab-python-#{node['mecab']['version']}.tar.gz"

remote_file mecab_python_src_filepath do
	source mecab_python_src_url
	checksum node['mecab']['python']['checksum']
	backup false
end

bash "compile_mecab_python_source" do
	cwd ::File.dirname(mecab_python_src_filepath)
	code <<-EOH
		tar zxf #{::File.basename(mecab_python_src_filepath)} -C #{::File.dirname(mecab_python_src_filepath)} &&
		cd mecab-python-#{node['mecab']['version']} &&
		#{node['python']['bin_path']}/python setup.py install
	EOH
end


