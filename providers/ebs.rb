require 'json'
include Opscode::Aws::Ec2

#only does one volume for the instance right now.  TODO:Update to make work with multiples
action :tag do
    	ebs_vols = currently_attached_volumes(node['ec2']['instance_id'])
    	ebs_vols.each do | ebs_vol |
    		aws_resource_tag 'chef generated volume' do
    			resource_id ebs_vol[:aws_id]
        		tags(node['aws-tag']['tags'])
        		action :update
			end
		end
end

# Returns the volume that's attached to the instance at the given device or nil if none matches
def currently_attached_volumes(instance_id)
  ec2.describe_volumes.select {|v| v[:aws_instance_id] == instance_id}
  #ec2.describe_volumes.find do |v|
  #  v[:aws_instance_id] == instance_id
  #end
end

