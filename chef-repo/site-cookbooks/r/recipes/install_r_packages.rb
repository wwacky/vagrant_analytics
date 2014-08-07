#
# Cookbook Name:: r
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


bash "compile_mecab_python_source" do
	cwd ::File.dirname(mecab_python_src_filepath)
	code <<-EOH
		options(repos="http://cran.ism.ac.jp/")
		R --no-save < /tmp/r_packages.R
	EOH
end
