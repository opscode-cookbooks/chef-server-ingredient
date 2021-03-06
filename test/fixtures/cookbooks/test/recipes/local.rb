# helper methods for recipe clariy

pkgname = ::File.basename(node['test']['source_url'])
cache_path = Chef::Config[:file_cache_path]

# recipe
remote_file "#{cache_path}/#{pkgname}" do
  source node['test']['source_url']
  mode '0644'
end

chef_server_ingredient 'chef-server-core' do
  package_source "#{cache_path}/#{pkgname}"
  action [:install]
end

file '/tmp/chef-server-core.firstrun' do
  content 'ilovechef\n'
  notifies :reconfigure, 'chef_server_ingredient[chef-server-core]'
  action :create
end
