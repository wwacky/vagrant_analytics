#
# Cookbook Name:: mecab
# Recipe:: mecab
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

mecab_src_url = "https://mecab.googlecode.com/files/mecab-#{node['mecab']['version']}.tar.gz"
mecab_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/mecab-#{node['mecab']['version']}.tar.gz"

remote_file mecab_src_filepath do
  source mecab_src_url
  checksum node['mecab']['checksum']
  backup false
end

bash "compile_mecab_source" do
  cwd ::File.dirname(mecab_src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(mecab_src_filepath)} -C #{::File.dirname(mecab_src_filepath)} &&
    cd mecab-#{node['mecab']['version']} &&
    ./configure &&
    make &&
    make check &&
    make install
  EOH
end

