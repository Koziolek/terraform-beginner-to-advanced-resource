provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "lb" {
  vpc = true
}

output "eip" {
  value = aws_eip.lb.public_ip
}

resource "aws_s3_bucket" "mys3" {
  bucket = "my-attr-demo"
}


output "mys3bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
}
