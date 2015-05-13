#include_recipe "aws"
#::Chef::Recipe.send(:include, Opscode::Aws::Ec2)
include Opscode::Aws::Ec2

#only does one volume for the instance right now.  TODO:Update to make work with multiples
action :tag do
    	ebs_vol = determine_volume(node['ec2']['instance_id'])
    	aws_resource_tag 'chef generated volume' do
    	resource_id lazy { node['aws']['ebs_volume']['db_ebs_volume']['volume_id'] }
        tags(node['aws-tag']['tags'])
        action :update
	end
end

# Pulls the volume id from the volume_id attribute or the node data and verifies that the volume actually exists
def determine_volume(instance_id)
  vol = currently_attached_volume(instance_id)
  vol_id = (vol ? vol[:volume_id] : nil)
  fail 'volume_id attribute not set and no volume id is set in the node data for this resource (which is populated by action :create) and no volume is attached at the device' unless vol_id
  # check that volume exists
  vol = volume_by_id(vol_id)
  fail "No volume with id #{vol_id} exists" unless vol
  vol
end

# Retrieves information for a volume
def volume_by_id(volume_id)
  ec2.describe_volumes[:volumes].find { |v| v[:volume_id] == volume_id }
end

# Returns the volume that's attached to the instance at the given device or nil if none matches
def currently_attached_volume(instance_id)
  Chef::Log.info "Getting currently attached volumes for instance #{instance_id}"
  ec2.describe_volumes[:volumes].find do |v|
    Chef::Log.info "volume info #{v}"
    v[:attachments].any? { |a| a[:instance_id] == instance_id }
  end
end

