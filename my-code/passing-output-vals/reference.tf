provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "myec2" {
  ami = "ami-00edb93a4d68784e3"
  instance_type = "t2.micro"
  security_groups = [
    "default"
  ]
}

resource "aws_eip" "lb" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name = "allow-tls"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
  }
}