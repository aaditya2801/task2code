variable "my_s3_bucketname" {}
variable "my_s3_acl" {}
variable "my_s3_key" {}
variable "my_s3_source" {}

// S3 bucket :

resource "aws_s3_bucket" "s3bucketjob1" {
bucket = var.my_s3_bucketname
acl    = var.my_s3_acl
}

// Putting Objects in mynewbucketforjob1 :

resource "aws_s3_bucket_object" "s3_object" {
  bucket = aws_s3_bucket.s3bucketjob1.bucket
  key    = var.my_s3_key
  source = var.my_s3_source
  acl    = var.my_s3_acl
}
