#
# Cookbook Name:: polkit
# Recipe:: default
#

#require 'fileutils'
#include FileUtils

udisk_policy = "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy"
cookbook_file udisk_policy do
  if File.exist? udisk_policy and not File.exist? "#{udisk_policy}.orig"
    FileUtils.copy cookbooks-chef-amian, "#{udisks_policy}.orig"
  end

  source "udisks.policy"
  owner "root"
  group "root"
  mode "0644"
end

desktop_pkla = "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla"
template desktop_pkla do
  if node.attribute?('usermount')
    if File.exist? desktop_pkla and not File.exist? "#{desktop_pkla}.orig"
      FileUtils.copy desktop_pkla, "#{desktop_pkla}.orig"
    end
    users = node[:usermount].inject("") { |users,user| users << ";unix-user:#{user}" }

    owner "root"
    group "root"
    mode "0644"
    variables :user_mount => users
    source "com.ubuntu.desktop.pkla.erb"
  end
end

#def remove() 
#    Chef::Log.info("test remove method")
#end
