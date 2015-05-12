include_recipe "aws"

unless node['aws-tag']['tags'].empty? || node['aws-tag']['tags'].nil?
    aws_resource_tag node['ec2']['instance_id'] do
        tags(node['aws-tag']['tags'])
        action :update
    end
    
    chef_aws_tag_ebs_tag node['ec2']['instance_id'] do
    	tags(node['aws-tag']['tags'])
    	action :tag
    end
end
