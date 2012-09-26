node['nginx']['domain'] = 'turbinehq.com'

node['nginx']['ssl_dir'] = "#{node['nginx']['dir']}/ssl"
node['nginx']['crt_file'] = "#{node['nginx']['ssl_dir']}/#{node['nginx']['domain']}.crt"
node['nginx']['key_file'] = "#{node['nginx']['ssl_dir']}/#{node['nginx']['domain']}.key"

directory node['nginx']['ssl_dir'] do
  user 'root'
  group 'root'
  mode '775'
  recursive true
end

template node['nginx']['crt_file'] do
  only_if { !File.file?(node['nginx']['crt_file']) }
  source 'crt.erb'
  user 'root'
  group 'root'
  mode '664'
end

template node['nginx']['key_file'] do
  only_if { !File.file?(node['nginx']['key_file']) }
  source 'key.erb'
  user 'root'
  group 'root'
  mode '664'
end
