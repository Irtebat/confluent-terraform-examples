resource "confluent_kafka_topic" "main" {

  kafka_cluster {
    id = var.kafka_id
  }
  rest_endpoint = var.kafka_rest_endpoint

  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }

  for_each = var.topics

  topic_name       = each.key
  partitions_count = each.value.partitions_count
  config           = each.value.config

  # lifecycle {
  #   prevent_destroy = true
  # }
}
