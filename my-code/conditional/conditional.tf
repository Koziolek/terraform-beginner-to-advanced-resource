provider "aws" {
  region = "eu-central-1"
}

locals {
  common_tags = {
    Owner   = "Devops team"
    service = "backend"
  }
}

data "aws_ami" "app_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "test" {
  ami           = data.aws_ami.app_ami.id //"ami-00edb93a4d68784e3"
  instance_type = "t2.nano"               //var.instancetype
  count         = var.is_test == true ? 1 : 0
  tags          = local.common_tags
}

resource "aws_instance" "prod" {
  ami           = "ami-00edb93a4d68784e3"
  instance_type = "t2.micro" // var.instancetype
  count         = var.is_test == false ? 1 : 0
}