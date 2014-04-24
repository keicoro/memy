#
# Cookbook Name:: tmux
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# ref: http://jtskarbek.wordpress.com/2013/03/22/tmux-compile-failure/

package "libevent" do
  action :remove
end

package "libevent-devel" do
  action :remove
end

package "libevent-headers" do
  action :remove
end

package "wget" do
  action :install
end

package "gcc" do
  action :install
end

package "ncurses" do
  action :install
end

package "ncurses-devel" do
  action :install
end

bash "install libevent" do
  not_if 'which tmux'
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
      wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
      tar zxvf libevent-2.0.21-stable.tar.gz
      cd libevent-2.0.21-stable
      ./configure
      make
      make install
      ldconfig
      EOH
end

bash "install tmux" do
  not_if 'which tmux'
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
      wget http://downloads.sourceforge.net/tmux/tmux-1.7.tar.gz
      tar zxvf tmux-1.7.tar.gz
      cd tmux-1.7
      ./configure
      make
      make install
      EOH
end