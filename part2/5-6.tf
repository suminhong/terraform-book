# main.tf
provider "aws" {
  alias  = "seoul"
  region = "ap-northeast-2"
}

provider "aws" {
  alias  = "tokyo"
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "bucket_seoul" {
  provider = aws.seoul
  bucket   = "${var.bucket_prefix}-seoul"
}

resource "aws_s3_bucket" "bucket_tokyo" {
  provider = aws.tokyo
  bucket   = "${var.bucket_prefix}-tokyo"
}