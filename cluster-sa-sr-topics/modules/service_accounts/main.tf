data "confluent_kafka_cluster" "k_cluster" {
  id = var.ccloud_kafka_cluster_id
  environment {
    id = var.ccloud_env_id
  }
}

data "confluent_schema_registry_cluster" "sr_cluster" {
  id = var.ccloud_sr_cluster_id
  environment {
    id = var.ccloud_env_id
  }
}


resource "confluent_service_account" "sa_app_rw_all" {
  display_name = var.ccloud_sa_name
  description  = "Service Account for application in env ${var.ccloud_env_id} and kafka cluster ${var.ccloud_kafka_cluster_id}"
}

resource "confluent_api_key" "sa_app_rw_all" {
  disable_wait_for_ready = true
  display_name = "kafka-api-key ${confluent_service_account.sa_app_rw_all.id}"
  description  = "Kafka API Key that is owned by ${confluent_service_account.sa_app_rw_all.id} service account"
  owner {
    id          = confluent_service_account.sa_app_rw_all.id
    api_version = confluent_service_account.sa_app_rw_all.api_version
    kind        = confluent_service_account.sa_app_rw_all.kind
  }

  managed_resource {
    id          = data.confluent_kafka_cluster.k_cluster.id
    api_version = data.confluent_kafka_cluster.k_cluster.api_version
    kind        = data.confluent_kafka_cluster.k_cluster.kind

    environment {
      id = var.ccloud_env_id
    }
  }
}

resource "confluent_api_key" "schema-registry-api-key" {
  disable_wait_for_ready = true
  display_name = "schema-registry-api-key"
  description  = "Schema Registry API Key"
  owner {
    id          = confluent_service_account.sa_app_rw_all.id
    api_version = confluent_service_account.sa_app_rw_all.api_version
    kind        = confluent_service_account.sa_app_rw_all.kind
  }

  managed_resource {
    id          = data.confluent_schema_registry_cluster.sr_cluster.id
    api_version = data.confluent_schema_registry_cluster.sr_cluster.api_version
    kind        = data.confluent_schema_registry_cluster.sr_cluster.kind

    environment {
      id = var.ccloud_env_id
    }
  }
}

resource "confluent_role_binding" "sa_app_developer_manage_topics" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperManage"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/topic=*"
}

resource "confluent_role_binding" "sa_app_developer_manage_groups" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperManage"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/group=*"
}

resource "confluent_role_binding" "sa_app_developer_manage_transactional_id" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperManage"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/transactional-id=*"
}

resource "confluent_role_binding" "sa_app_developer_manage_subjects" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperManage"
  crn_pattern = "${data.confluent_schema_registry_cluster.sr_cluster.resource_name}/subject=*"
}

resource "confluent_role_binding" "sa_app_developer_read_topics" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/topic=*"
}

resource "confluent_role_binding" "sa_app_developer_read_groups" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/group=*"
}

resource "confluent_role_binding" "sa_app_developer_read_transactional_id" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/transactional-id=*"
}

resource "confluent_role_binding" "sa_app_developer_read_subjects" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${data.confluent_schema_registry_cluster.sr_cluster.resource_name}/subject=*"
}

resource "confluent_role_binding" "sa_app_developer_write_topics" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/topic=*"
}

# resource "confluent_role_binding" "sa_app_developer_write_groups" {
#   principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
#   role_name   = "DeveloperWrite"
#   crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/group=*"
# }

resource "confluent_role_binding" "sa_app_developer_write_transactional_id" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${data.confluent_kafka_cluster.k_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.k_cluster.id}/transactional-id=*"
}

resource "confluent_role_binding" "sa_app_developer_write_subjects" {
  principal   = "User:${confluent_service_account.sa_app_rw_all.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${data.confluent_schema_registry_cluster.sr_cluster.resource_name}/subject=*"
}
