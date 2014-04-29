include NDAwsLibs::AWS::ElastiCache

def whyrun_supported?
  true
end

action :create do
  if cluster_exists?(@new_resource.cache_cluster_id)
    Chef::Log.info "Cache cluster #{@new_resource.cache_cluster_id} already exists...nothing to do."
    set_node_attribs(@new_resource)
  else
    converge_by "Create #{@new_resource.cache_cluster_id}" do
      Chef::Log.info "Creating #{@new_resource.cache_cluster_id}, this could take a few minutes."
      create_cluster(@new_resource)
      Chef::Log.info "Created #{@new_resource.cache_cluster_id}."
      set_node_attribs(@new_resource)
      if @new_resource.store_in_etcd
        get_cluster_info(@new_resource.cache_cluster_id).each do |cluster|
          etcd "/aws_elasticache/#{cluster.cache_cluster_id}/configuration_endpoint" do
            action :set
            value cluster.configuration_endpoint.address
          end
          cluster.cache_nodes.each do |cluster_node|
            etcd "/aws_elasticache/#{cluster.cache_cluster_id}/nodes/#{cluster_node.cache_node_id}/address" do
              action :set
              value "#{cluster_node.endpoint.address}:#{cluster_node.endpoint.port}"
            end
          end
        end
      end
    end
  end
end

