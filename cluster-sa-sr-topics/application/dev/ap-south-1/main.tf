module "private_dedicated_clusters" {
  source = "../../../modules/kafka_cluster"
  count  = length(var.private_dedicated_clusters)

  display_name        = var.private_dedicated_clusters[count.index].display_name
  ccloud_env_id       = var.private_dedicated_clusters[count.index].ccloud_env_id
  ccloud_network_id   = var.private_dedicated_clusters[count.index].ccloud_network_id
  ccloud_cluster_ckus = var.private_dedicated_clusters[count.index].ccloud_cluster_ckus
  ccloud_region       = var.private_dedicated_clusters[count.index].ccloud_region
  ccloud_provider     = var.private_dedicated_clusters[count.index].ccloud_provider
  ccloud_availability = var.private_dedicated_clusters[count.index].ccloud_availability

}

# module "sr_clusters" {
#   source = "../../../modules/schema_registry"
#   count  = length(var.sr_clusters)

#   ccloud_env_id      = var.sr_clusters[count.index].ccloud_env_id
#   ccloud_sr_provider = var.sr_clusters[count.index].ccloud_sr_provider
#   ccloud_sr_region   = var.sr_clusters[count.index].ccloud_sr_region
#   ccloud_sr_package  = var.sr_clusters[count.index].ccloud_sr_package
# }

module "service_accounts" {

    source   = "../../../modules/service_accounts"
    count = length(module.private_dedicated_clusters.*.kafka_cluster_id)
   
    ccloud_env_id           = "env-dod3m7"
    ccloud_kafka_cluster_id = module.private_dedicated_clusters.*.kafka_cluster_id[count.index]
    ccloud_sa_name          = "sa-app-${module.private_dedicated_clusters.*.kafka_cluster_id[count.index]}"
    ccloud_sr_cluster_id    = "lsrc-8wz175"

}

locals {
    topic_json_files = fileset("${path.module}/topics/", "*.json")   
    topic_json_data  = merge([ for f in local.topic_json_files : jsondecode(file("${path.module}/topics/${f}")) ]...)
    
}

module "confluent_kafka_topics" {
  
  source = "../../../modules/manage-topics-via-json"
  count = length(module.private_dedicated_clusters.*.kafka_cluster_id)

  kafka_id            = module.private_dedicated_clusters.*.kafka_cluster_id[count.index]
  kafka_rest_endpoint = module.private_dedicated_clusters.*.rest_endpoint[count.index]
  kafka_api_key       = module.service_accounts.*.sa_app_rw_api_key[count.index]
  kafka_api_secret    = module.service_accounts.*.sa_app_rw_api_secret[count.index]

  topics  = local.topic_json_data
}


