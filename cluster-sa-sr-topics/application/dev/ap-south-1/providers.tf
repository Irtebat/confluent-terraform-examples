terraform {
  backend "s3" {
    bucket         = "gdc-internal-bucket"
    key            = "tf/learning_cluster_2.tfstate"
    region         = "ap-south-1"
   
  }
  required_version = ">= 0.14.0"

  required_providers {
    
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.39.0"
    }
  
  }
}

