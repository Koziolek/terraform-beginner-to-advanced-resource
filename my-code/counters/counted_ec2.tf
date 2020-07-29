provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "myec2" {
  ami = "ami-00edb93a4d68784e3"
  instance_type = "t2.micro"
  security_groups = [
    "default"
  ]
  count = 3
}