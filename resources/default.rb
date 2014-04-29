actions :create, :update, :delete
default_action :create

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
