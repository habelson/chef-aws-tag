include Opscode::Aws::Ec2

def whyrun_supported?
  true
end

 action :describe do
	unless @new_resource.instance_id 
5     instance_id = @new_resource.name 
6   else 
7     instance_id = @new_resource.instance_id 
8   end 

	vol = ec2.describe_volumes[:volumes].find do |v|
		v[:attachments].any? { |a| a[:instance_id] == instance_id }
	end
	Chef::Log.info "Found volumes #{vol}"
end
