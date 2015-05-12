include_recipe "aws"
::Chef::Recipe.send(:include, Opscode::Aws::Ec2)

