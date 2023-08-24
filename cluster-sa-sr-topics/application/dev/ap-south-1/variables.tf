# variable "ccloud_map_env_kafka" {
#   type = map(string)
# }

# variable "ccloud_map_env_sr" {
#   type = map(string)
# }

variable "private_dedicated_clusters" {
  type = list(object({
    display_name        = string
    ccloud_env_id       = string
    ccloud_network_id   = string
    ccloud_availability = string
    ccloud_region       = string
    ccloud_cluster_ckus = number
    ccloud_provider     = string
  }))
}

variable "sr_clusters" {
  type = list(object({
    ccloud_env_id      = string
    ccloud_sr_region   = string
    ccloud_sr_provider = string
    ccloud_sr_package  = string
  }))
}

# variable "kafka_api_key" {
#   description = "Kafka API Key that is owned by service account that has permissions to create topics (e.g., has at least CloudClusterAdmin role)"
#   type        = string
#   #sensitive   = true
# }

# variable "kafka_api_secret" {
#   description = "Kafka API Secret"
#   type        = string
#   #sensitive   = true
# }

# variable "kafka_rest_endpoint" {
#   description = "The REST Endpoint of the Kafka cluster"
#   type        = string
# }

# variable "kafka_id" {
#   description = "The ID the the Kafka cluster of the form 'lkc-'"
#   type        = string
# }
