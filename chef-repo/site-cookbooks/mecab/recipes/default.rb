#
# Cookbook Name:: mecab
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mecab::mecab'
include_recipe 'mecab::mecab-ipadic'
include_recipe 'mecab::mecab-python'

include_recipe 'mecab::cabocha'
include_recipe 'mecab::cabocha-python'


