data "confluent_schema_registry_region" "sr" {
  cloud   = var.ccloud_sr_provider
  region  = var.ccloud_sr_region
  package = var.ccloud_sr_package
}

resource "confluent_schema_registry_cluster" "sr" {
  package = data.confluent_schema_registry_region.sr.package

  environment {
    id = var.ccloud_env_id
  }

  region {
    id = data.confluent_schema_registry_region.sr.id
  }
}
