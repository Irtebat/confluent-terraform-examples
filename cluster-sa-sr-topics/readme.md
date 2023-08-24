## About
Template to provision clusters at scale (dev,qa,prod - region) in a pre-created confluent cloud environment, create admin service account, and create topics via a json interface.
Modules: Cluster, Schema Registry, Service Accounts, Topics-via-JSON
Entry-point: application/

## To run this tf code

```
export CONFLUENT_CLOUD_API_KEY="" ; export CONFLUENT_CLOUD_API_SECRET=""
tf init
tf plan
```