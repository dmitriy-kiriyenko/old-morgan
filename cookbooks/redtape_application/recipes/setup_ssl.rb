directory "#{node['nginx']['dir']}/ssl" do
  user 'root'
  group 'root'
  mode '775'
  recursive true
end
