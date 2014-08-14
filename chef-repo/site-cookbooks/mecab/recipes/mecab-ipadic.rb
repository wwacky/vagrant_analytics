#
# Cookbook Name:: mecab
# Recipe:: mecab-ipadic
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ipadic_src_url = "https://mecab.googlecode.com/files/mecab-ipadic-#{node['mecab']['ipadic']['version']}.tar.gz"
ipadic_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/mecab-ipadic-#{node['mecab']['ipadic']['version']}.tar.gz"

remote_file ipadic_src_filepath do
  source ipadic_src_url
  checksum node['mecab']['ipadic']['checksum']
  backup false
end

bash "unarchive_and_configure_ipadic" do
	cwd ::File.dirname(ipadic_src_filepath)
	code <<-EOH
		tar zxf #{::File.basename(ipadic_src_filepath)} -C #{::File.dirname(ipadic_src_filepath)} &&
		cd mecab-ipadic-#{node['mecab']['ipadic']['version']} &&
	./configure --with-charset=utf-8
	EOH
end

#additonal_dictionary_path = node['mecab']['additonal_dictionary_path']
#if node['mecab']['additonal_dictionary_path']
#	bash "copy_additional_dictionary_files" do
#		cwd ::File.dirname(ipadic_src_filepath)
#		code <<-EOH
#			cd mecab-ipadic-#{node['mecab']['ipadic']['version']} &&
#			cp #{additonal_dictionary_path}/*.csv . &&
#			/usr/local/libexec/mecab/mecab-dict-index -f euc-jp -t utf8
#		EOH
#	end
#end

bash "make_and_install_ipadic" do
	cwd ::File.dirname(ipadic_src_filepath)
	code <<-EOH
		cd mecab-ipadic-#{node['mecab']['ipadic']['version']} &&
		make &&
		make install
	EOH
end

