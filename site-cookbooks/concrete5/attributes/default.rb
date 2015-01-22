# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2



default[:concrete5][:db][:name] = "concrete5"
default[:concrete5][:db][:user] = "concrete5"
default[:concrete5][:db][:pass] = node[:ec2][:instance_id]
default[:concrete5][:db][:host] = 'localhost'


default[:concrete5][:admin][:email]    = 'admin@example.com'
default[:concrete5][:admin][:password] = node[:ec2][:instance_id]

default[:concrete5][:starting_point] = 'blank'
default[:concrete5][:site]           = 'Concrete5 Site'
default[:concrete5][:install_path]   = '/var/www/concrete5'
default[:concrete5][:reinstall]      = 'no'

default[:concrete5][:demo][:user_name] = ''
default[:concrete5][:demo][:password]  = ''
default[:concrete5][:demo][:email]     = ''

