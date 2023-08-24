output "bootstrap_server" {
  value = confluent_kafka_cluster.dedicated.bootstrap_endpoint
}

output "rest_endpoint" {
  value = confluent_kafka_cluster.dedicated.rest_endpoint
}

output "kafka_cluster_id" {
  value = confluent_kafka_cluster.dedicated.id
}
