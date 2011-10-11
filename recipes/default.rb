#
# Cookbook Name:: polkit
# Recipe:: default
#

#require 'fileutils'
#include FileUtils


cookbook_file "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy" do
  if (FileTest.exist?( "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy" ) and not FileTest.exist?( "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy.orig" ) )
    FileUtils.cp_r "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy", "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy.orig"
  end

  source "udisks.policy"
  owner "root"
  group "root"
  mode "0644"
end

template "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla" do
  if node.attribute?('usermount')
    if (FileTest.exist?( "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla" ) and not FileTest.exist?( "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla.orig" ))
      FileUtils.cp_r "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla", "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla.orig"
 
    end
    users=""
    for x in node[:usermount] do
       users=users+";unix-user:"+x
    end
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
