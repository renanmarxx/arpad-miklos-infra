resource "aws_s3_bucket" "this" {
  bucket = var.remote_backend.bucket_name

}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id = "Expire old versions"


    filter {
      object_size_greater_than = 1
    }

    status = "Enabled"

    transition {
      days          = 1
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 3
      storage_class   = "GLACIER_IR"
    }

    noncurrent_version_expiration {
      noncurrent_days = 5
    }

    expiration {
      days = 7
    }
  }
}
