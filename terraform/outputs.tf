output "queue_arns" {
  value = aws_sqs_queue.this[*].arn
}

output "bucket_arns" {
  value = aws_s3_bucket.this[*].arn
}
