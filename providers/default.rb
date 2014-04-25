include NDAwsLibs::AWS::ElastiCache

def whyrun_supported?
  true
end

action :create do
  if cluster_exists?(@new_resource.cache_cluster_id)
    Chef::Log.info "Cache cluster #{@new_resource.cache_cluster_id} already exists...nothing to do."
    set_node_attribs
  else
    converge_by "Create #{@new_resource.cache_cluster_id}" do
      Chef::Log.info "Creating #{@new_resource.cache_cluster_id}, this could take a few minutes."
      create_cluster(@new_resource)
      Chef::Log.info "Created #{@new_resource.cache_cluster_id}."
      set_node_attribs(@new_resource)
    end
  end
end

