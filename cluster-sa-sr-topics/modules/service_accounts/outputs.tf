output "sa_app_rw_api_key" {
  value = confluent_api_key.sa_app_rw_all.id
}

output "sa_app_rw_api_secret" {
  value = confluent_api_key.sa_app_rw_all.secret
}

output "sr_api_key" {
  value = confluent_api_key.schema-registry-api-key.id
}

output "sr_api_secret" {
  value = confluent_api_key.schema-registry-api-key.secret
}
