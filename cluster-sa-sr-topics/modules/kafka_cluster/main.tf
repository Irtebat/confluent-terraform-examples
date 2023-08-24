resource "confluent_kafka_cluster" "dedicated" {
  display_name = var.display_name
  availability = var.ccloud_availability
  cloud        = var.ccloud_provider
  region       = var.ccloud_region
  dedicated {
    cku = var.ccloud_cluster_ckus
  }
  environment {
    id = var.ccloud_env_id
  }
  network {
    id = var.ccloud_network_id
  }
}
