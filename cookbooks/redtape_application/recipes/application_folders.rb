# FIXME: all these strings should be taken from attributes
directory '/var/www/apps' do
  owner 'deploy'
  group 'deploy'
  mode '775'
  recursive true
end
