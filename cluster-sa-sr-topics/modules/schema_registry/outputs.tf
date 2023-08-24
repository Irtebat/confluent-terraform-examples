output "sr_endpoint" {
  value = confluent_schema_registry_cluster.sr.rest_endpoint
}

output "sr_cluster_id" {
  value = confluent_schema_registry_cluster.sr.id
}