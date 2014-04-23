#
# Cookbook Name:: grant_sudo
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group 'memy' do
  group_name 'memy'
  action :create
end

user 'memy' do
  comment ''
  group 'memy'
  home '/home/memy'
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end

node.override['authorization']['sudo']['groups']            = ['vagrant', 'memy']
node.override['authorization']['sudo']['users']             = ['vagrant', 'memy']
node.override['authorization']['sudo']['passwordless']      = true
node.override['authorization']['sudo']['sudoers_defaults']  = ['!lecture,tty_tickets,!fqdn']

include_recipe 'sudo::default'
