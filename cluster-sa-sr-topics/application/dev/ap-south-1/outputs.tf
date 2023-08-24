output "api_key" {
  value = module.service_accounts.*.sa_app_rw_api_key
}

output "api_secret" {
  value     = module.service_accounts.*.sa_app_rw_api_secret
  sensitive = true
}


output "sr_api_key" {
  value = module.service_accounts.*.sr_api_key
}

output "sr_api_secret" {
  value     = module.service_accounts.*.sr_api_secret
  sensitive = true
}

output "private_dedicated_clusters" {
  value     = module.private_dedicated_clusters
}


output "dedicated_cluster_bootstrap_server" {
  value = module.private_dedicated_clusters.*.bootstrap_server
}

output "dedicated_cluster_rest_endpoint" {
  value = module.private_dedicated_clusters.*.rest_endpoint
}

output "kafka_cluster_id" {
  value = module.private_dedicated_clusters.*.kafka_cluster_id
}


# output "sr_cluster_id" {
#   value = module.sr_clusters.*.sr_cluster_id
# }

# output "sr_endpoint" {
#   value = module.sr_clusters.*.sr_endpoint
# }

# output "created_kafka_topics" {
#   description = "Map of created Confluent Kafka topics"
#   value       = module.confluent_kafka_topics.kafka_topics
# }
