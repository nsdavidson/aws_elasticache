# aws_elasticache

Provides an aws_elasticache resource to provision AWS Elasticache instances.


## Attributes

```
attribute :aws_access_key, kind_of: String, required: true
attribute :aws_secret_access_key, kind_of: String, required: true
attribute :region, kind_of: String, required: true
attribute :cache_cluster_id, kind_of: String, name_attribute: true
attribute :num_cache_nodes, kind_of: Integer, required: true
attribute :cache_node_type, kind_of: String, required: true
attribute :engine, kind_of: String, required: true
attribute :engine_version, kind_of: String, required: true
attribute :cache_parameter_group_name, kind_of: String, required: true
attribute :cache_subnet_group_name, kind_of: String, required: true
attribute :security_group_ids, kind_of: Array, required: true
attribute :port, kind_of: Integer, required: true
attribute :auto_minor_version_upgrade, kind_of: [TrueClass, FalseClass], default: false
attribute :store_in_etcd, kind_of: [TrueClass, FalseClass], default:false
```

## Usage

From the included test recipe.

```
include_recipe "aws_elasticache::default"

aws_elasticache "chef-test" do
  aws_access_key node['aws_access_key']
  aws_secret_access_key node['aws_secret_access_key']
  region "eu-west-1"
  cache_node_type "cache.t1.micro"
  engine "memcached"
  cache_parameter_group_name "default.memcached1.4"
  cache_subnet_group_name "subnetgroup1"
  security_group_ids ["security_group_id"]
  port 11211
  num_cache_nodes 1
  auto_minor_version_upgrade true
end
```

### aws-elasticache::default

Include `aws_elasticache` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[aws_elasticache::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Nolan Davidson (<nolan.davidson@gmail.com>)
