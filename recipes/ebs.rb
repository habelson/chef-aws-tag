include_recipe "aws"

chef-aws-tag_ebs_volume node['ec2']['instance_id'] do
	action :describe
end





