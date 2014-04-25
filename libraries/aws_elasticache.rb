

module NDAwsLibs
  module AWS
    module ElastiCache

      ATTRIBS_TO_SEND = [
        :cache_cluster_id,
        :num_cache_nodes,
        :cache_node_type,
        :engine,
        :cache_parameter_group_name,
        :cache_subnet_group_name,
        :security_group_ids,
        :port,
        :auto_minor_version_upgrade
      ]

      def ec_connection(key = new_resource.aws_access_key, secret = new_resource.aws_secret_access_key, region = new_resource.region)
        begin
          require "aws-sdk-core"
        rescue LoadError
          Chef::Log.error("Missing gem aws-sdk-core.  Apply aws-elasticache::default to install it.")
        end
        @ec_conn ||= Aws::ElastiCache.new(access_key_id: key, secret_access_key: secret, region: region)
      end

      def cluster_exists?(cluster_id)
        begin
          @cluster = ec_connection.describe_cache_clusters(cache_cluster_id: cluster_id).cache_clusters
        rescue Aws::ElastiCache::Errors::CacheClusterNotFound
          return false
        end
        return true
      end

      def create_cluster(attribs)
        if @cluster = ec_connection.create_cache_cluster(get_attribs_from_object(attribs))
          while get_cluster_status(attribs.cache_cluster_id) != 'available' do
            sleep 2
          end
        end
      end

      def get_cluster_status(id)
        ec_connection.describe_cache_clusters(cache_cluster_id: id).cache_clusters.first.cache_cluster_status
      end

      def get_cluster_info(id)
        ec_connection.describe_cache_clusters(cache_cluster_id: id).cache_clusters
      end

      def get_attribs_from_object(resource)
        attribs = {}
        ATTRIBS_TO_SEND.each do |key|
          if value = resource.send(key)
            attribs[key] = value
          end
        end
        attribs
      end

      def set_node_attribs(resource)
        get_cluster_info(resource.cache_cluster_id).cluster.each do |cluster|
          node.override[:aws_elasticache][cluster.cache_cluster_id][:configuration_endpoint] = cluster.configuration_endpoint
          cluster.cache_nodes.endpoint.each do |ep|
            node.override[:aws_elasticache][cluster.cache_cluster_id][:nodes] << "#{ep.address}:#{ep.port}"
          end
          puts node[:aws_elasticache][cluster.cache_cluster_id][:nodes]
        end
      end

    end
  end
end