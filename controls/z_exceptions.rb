@chef_node = attribute('chef_node', description: 'Chef Node', default: {})
unless defined?(@chef_node)
  #support running outside of chef audit cookbook
  return
end

node_exceptions = @chef_node['exceptions'] if defined?(@chef_node['exceptions'])
node_exceptions = [] if node_exceptions.nil?

if @chef_node['os'] == 'windows'
  auditor = 'C:/chef/cache/audit.json'
else
  auditor = '/var/chef/cache/audit.json'
end

databag_exceptions = (eval(File.read(auditor))["exceptions"] if File.readable?(auditor))
databag_exceptions = [] if databag_exceptions.nil?

ObjectSpace.each_object(Inspec::Rule) do |r|
   r.only_if('Excluded by chef environment (attribute) exception.') { false } if node_exceptions.include?(r.to_s)
   r.only_if('Excluded by hardening form (databag) exception.') { false } if databag_exceptions.include?(r.to_s)
end
