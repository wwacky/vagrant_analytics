#
# Author:: Seth Chisamore <schisamo@opscode.com>
# Cookbook Name:: python
# Recipe:: virtualenv
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "yum-epel"
include_recipe "python::pip"
include_recipe "python::virtualenv"

#install pkg for numpy/scipy
#	freetype freetype-devel
%w{
	gcc
	zlib-devel
	sqlite-devel
	openssl-devel
	gcc-gfortran
	blas blas-devel
	lapack lapack-devel
	atlas-sse3 atlas-sse3-devel
}.each do |pkg|
    package pkg do
        action :install
    end
end

#make virtualenv
python_virtualenv node['python']['virtualenv_stats_dir'] do
  action :create
  owner "vagrant"
  group "vagrant"
end

#install statistics pkg
#	matplotlib
%w{
	nose
	numpy
	scipy
	scikit-learn
	pandas
	nltk
	gensim
	ipython[notebook]
	pyzmq
	tornado
}.each do |pp|
	python_pip pp do
		action :install
#		virtualenv node['python']['virtualenv_stats_dir']
	end
end

#install other pkg
%w{
	BeautifulSoup
}.each do |pp|
	python_pip pp do
		action :install
#		virtualenv node['python']['virtualenv_stats_dir']
	end
end
