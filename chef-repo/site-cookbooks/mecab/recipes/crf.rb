#
# Cookbook Name:: mecab
# Recipe:: crf
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

crf_src_url = "https://crfpp.googlecode.com/files/CRF%2B%2B-#{node['crf']['version']}.tar.gz"
crf_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/CRF++-#{node['crf']['version']}.tar.gz"

remote_file crf_src_filepath do
	source crf_src_url
	checksum node['crf']['checksum']
	backup false
end

bash "compile_crf_source" do
	cwd ::File.dirname(crf_src_filepath)
	code <<-EOH
		tar xzf CRF++-#{node['crf']['version']}.tar.gz &&
		cd CRF++-#{node['crf']['version']} &&
		./configure &&
		make &&
		make check &&
		make install
	EOH
end

