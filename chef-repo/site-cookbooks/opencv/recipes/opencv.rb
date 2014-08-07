#
# Cookbook Name:: opencv
# Recipe:: opencv
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

opencv_src_url = "http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/#{node['opencv']['version']}/opencv-#{node['opencv']['version']}.zip"
opencv_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/opencv-#{node['opencv']['version']}.zip"

remote_file opencv_src_filepath do
	source opencv_src_url
	checksum node['opencv']['checksum']
	backup false
end

#include_recipe "yum-epel"

%w{
	cmake28
	gtk2-devel
	libarchive
	libarchive-devel
}.each do |pkgname|
	package pkgname do
		action :install
	end
end

#bash "install_ready" do
#	code <<-EOH
#		yum groupinstall "Development Tools"
#	EOH
#end
#		yum --enablerepo=rpmforge install ffmpeg-devel


#		cd opencv-#{node['opencv']['version']} &&
#		cmake28 -DBUILD_DOCS=ON -DBUILD_EXAMPLES=ON -DBUILD_NEW_PYTHON_SUPPORT=ON  -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_PYTHON_SUPPORT=ON -DPYTHON_EXECUTABLE=#{node['python']['executable']} -DPYTHON_INCLUDE_DIR=#{node['python']['include']['dir']} -DPYTHON_LIBRARY=#{node['python']['library']} -DPYTHON_NUMPY_INCLUDE_DIR=#{node['python']['numpy']['include']['dir']} -DPYTHON_PACKAGES_PATH=#{node['python']['packages']['path']} . &&
#		make &&
#		make check &&
#		make install

bash "python_link" do
	code <<-EOH
		ln -sf /usr/local/lib/python2.7/config/libpython2.7.a /usr/local/lib/
	EOH
end

bash "compile_opencv_source" do
	cwd ::File.dirname(opencv_src_filepath)
	code <<-EOH
		unzip -o #{::File.basename(opencv_src_filepath)} &&
		cd opencv-#{node['opencv']['version']} &&
		cmake28 -DBUILD_DOCS=ON -DBUILD_EXAMPLES=ON -DBUILD_NEW_PYTHON_SUPPORT=ON  -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DINSTALL_PYTHON_EXAMPLES=ON -DPYTHON_EXECUTABLE=#{node['python']['executable']} -DPYTHON_INCLUDE_DIR=#{node['python']['include']['dir']} -DPYTHON_LIBRARY=#{node['python']['library']} -DPYTHON_NUMPY_INCLUDE_DIR=#{node['python']['numpy']['include']['dir']} -DPYTHON_PACKAGES_PATH=#{node['python']['packages']['path']} . &&
		make &&
		make install
	EOH
end

#-DBUILD_PYTHON_SUPPORT=ON

