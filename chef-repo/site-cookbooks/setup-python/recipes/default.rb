#
# Cookbook Name:: setup-python
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "pyenv::system"
#pyenv_python '2.7.6'

node.override['pyenv']['user_installs'] = [
  {
    'user'     => "#{node['ssh']['user']}",
    'pythons'  => ['2.7.6']
  }
]
include_recipe "pyenv::user"

execute "install-virtualenv-plugin" do
  not_if { ::File.exists?("/home/#{node['ssh']['user']}/.pyenv/plugins/pyenv-virtualenv") }
  user "#{node['ssh']['user']}"
  group "#{node['ssh']['user']}"
  command "git clone https://github.com/yyuu/pyenv-virtualenv.git /home/#{node['ssh']['user']}/.pyenv/plugins/pyenv-virtualenv; exec $SHELL"
end

bash "create-virtualenv" do
  not_if { ::File.exists?("/home/#{node['ssh']['user']}/.pyenv/versions/memy-venv-2.7.6") }
  user "#{node['ssh']['user']}"
  group "#{node['ssh']['user']}"
  environment 'HOME' => "/home/#{node['ssh']['user']}"
  code <<-EOH
  sudo su - #{node['ssh']['user']}
  source /etc/profile.d/pyenv.sh
  source /home/#{node['ssh']['user']}/.bash_profile
  /home/#{node['ssh']['user']}/.pyenv/bin/pyenv virtualenv 2.7.6 memy-venv-2.7.6
  EOH
end

