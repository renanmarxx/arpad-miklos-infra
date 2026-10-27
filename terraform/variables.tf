variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}

variable "assume_role" {
  description = "Whether to assume a role in the target AWS account"
  type = object({
    role_arn = string
  })
  default = {
    role_arn = "arn:aws:iam::535942231592:role/sentinelFullAccess-a5a1b092-38d5-4742-97b3-3e8ce1faea54"
  }
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "sentinel"
  }
}

variable "queues" {
  description = "A list of SQS queue names to create"
  type = list(object({
    name                      = string
    delay_seconds             = number
    max_message_size          = number
    message_retention_seconds = number
    receive_wait_time_seconds = number
  }))

  default = [
    {
      name                      = "queue-sentinel-01"
      delay_seconds             = 90
      max_message_size          = 2048
      message_retention_seconds = 86400
      receive_wait_time_seconds = 10
    },
    {
      name                      = "queue-sentinel-02"
      delay_seconds             = 90
      max_message_size          = 2048
      message_retention_seconds = 86400
      receive_wait_time_seconds = 10
    }
  ]
}

variable "remote_backend" {
  description = "Whether to use a remote backend for Terraform state"
  type = object({
    bucket_name                                   = string
    dynamodb_table_name                           = string
    dynamodb_table_billing_mode                   = string
    dynamodb_table_hash_key_attribute_name        = string
    dynamodb_table_hash_key_attribute_type        = string
    dynamodb_table_point_in_time_recovery_enabled = string
  })

  default = {
    bucket_name                                   = "renan-marx-data-engineering-projects"
    dynamodb_table_name                           = "dynamodb-sentinel-01"
    dynamodb_table_billing_mode                   = "PAY_PER_REQUEST"
    dynamodb_table_hash_key_attribute_name        = "LockID"
    dynamodb_table_hash_key_attribute_type        = "S"
    dynamodb_table_point_in_time_recovery_enabled = "true"
  }
}
