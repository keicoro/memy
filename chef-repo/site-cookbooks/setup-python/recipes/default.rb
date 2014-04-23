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
    'user'     => 'vagrant',
    'pythons'  => ['2.7.6']
  }
]
include_recipe "pyenv::user"

execute "install-virtualenv-plugin" do
  not_if { ::File.exists?('/home/vagrant/.pyenv/plugins/pyenv-virtualenv') }
  user "vagrant"
  group "vagrant"
  command "git clone https://github.com/yyuu/pyenv-virtualenv.git /home/vagrant/.pyenv/plugins/pyenv-virtualenv; exec $SHELL"
end

bash "create-virtualenv" do
  not_if { ::File.exists?('/home/vagrant/.pyenv/versions/memy-venv-2.7.6') }
  user "vagrant"
  group "vagrant"
  environment 'HOME' => '/home/vagrant'
  code <<-EOH
  sudo su - vagrant
  source /etc/profile.d/pyenv.sh
  source /home/vagrant/.bash_profile
  /home/vagrant/.pyenv/bin/pyenv virtualenv 2.7.6 memy-venv-2.7.6
  EOH
end

