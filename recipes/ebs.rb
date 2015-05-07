include_recipe "aws"
::Chef::Recipe.send(:include, Opscode::Aws::Ec2)



unless node['aws-tag']['tags'].empty? || node['aws-tag']['tags'].nil?
	vol = ec2.describe_volumes[:volumes].find do |v|
		v[:attachments].any? { |a| a[:instance_id] == node['ec2']['instance_id'] }
	end
	
    aws_resource_tag vol[:volume_id] do
        tags(node['aws-tag']['tags'])
        action :update
    end
end





