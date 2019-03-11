variable "num_of_buckets" {
  default = "1"
}

variable "owner" {
  default = "demouser"
}

variable "ttl" {
  default = "48h"
}

variable "bucket_name" {
  default = "tf-test-bucket"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "env" {
  default = "dev"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

resource "aws_s3_bucket" "s3-test" {
  count = "${var.num_of_buckets}"
  bucket = "${var.bucket_name}-${count.index}"
  acl    = "private"
  region   = "${var.aws_region}"

  tags {
    Name        = "${var.bucket_name}"
    Environment = "${var.env}"
    Owner       = "${var.owner}"
    TTL         = "${var.ttl}"
  }
}

output "bucket_ids" {
  value = "${aws_s3_bucket.s3-test.*.id}"
}