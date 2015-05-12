if defined?(ChefSpec)
  # ebs_raid
  def tag_instance_ebs_volumes(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_aws_tag_ebs, :tag, resource_name)
  end
end