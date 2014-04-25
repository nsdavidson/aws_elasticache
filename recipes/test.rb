include_recipe "aws_elasticache::default"

aws_elasticache "chef-test" do
  aws_access_key node['aws_access_key']
  aws_secret_access_key node['aws_secret_access_key']
  region "eu-west-1"
  cache_node_type "cache.t1.micro"
  engine "memcached"
  cache_parameter_group_name "default.memcached1.4"
  cache_subnet_group_name "fn-uk-stage"
  security_group_ids ["sg-beeb1fdb"]
  port 11211
  num_cache_nodes 1
  auto_minor_version_upgrade true
end