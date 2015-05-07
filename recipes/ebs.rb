
vol = ec2.describe_volumes[:volumes].find do |v|
	v[:attachments].any? { |a| a[:instance_id] == node['ec2']['instance_id'] }
	
end

Chef::Log.info "Found volumes #{vol}"



