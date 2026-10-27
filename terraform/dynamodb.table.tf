resource "aws_dynamodb_table" "this" {
  name         = var.remote_backend.dynamodb_table_name
  billing_mode = var.remote_backend.dynamodb_table_billing_mode
  hash_key     = var.remote_backend.dynamodb_table_hash_key_attribute_name

  attribute {
    name = var.remote_backend.dynamodb_table_hash_key_attribute_name
    type = var.remote_backend.dynamodb_table_hash_key_attribute_type
  }

  point_in_time_recovery {
    enabled = var.remote_backend.dynamodb_table_point_in_time_recovery_enabled
  }
}
