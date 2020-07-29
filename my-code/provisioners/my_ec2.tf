provider "tls" {

}
provider "aws" {
  region     = "eu-central-1"
}

variable "key_name" {
  default = "deployer"
  type = string
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "deployer" {
  key_name = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "aws_instance" "myec2" {
  ami = "ami-00edb93a4d68784e3"
  instance_type = "t2.micro"
  key_name = var.key_name

  provisioner "remote-exec" {
    inline =[
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = tls_private_key.this.private_key_pem
    }
  }
}