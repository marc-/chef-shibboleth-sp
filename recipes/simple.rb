#
# Cookbook Name:: shibboleth-sp
# Recipe:: simple
#
# Copyright 2012
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

include_recipe "shibboleth-sp"

case node['platform']
when 'windows'
	config_path = "C:/opt/shibboleth-sp/etc/shibboleth"
else
	config_path = "/etc/shibboleth"
end

template "#{config_path}/shibboleth2.xml" do
	source "shibboleth2.xml.erb"
	owner "root" unless platform? 'windows'
	group "root" unless platform? 'windows'
	mode "0644"
	notifies :restart, resources(:service => "shibd"), :delayed
end