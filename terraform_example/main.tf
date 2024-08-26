terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

##### Try to create one ubuntu server
resource "aws_instance" "ashwin1" {
  ami                     = var.ami
  instance_type           = var.instance_type
  key_name                = var.key_name

user_data = <<EOF
#!/bin/bash
sudo apt install nginx -y
sudo echo "<h2>Cloudblitz</h2>" > /var/www/html/index.nginx-debian.html
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  tags = var.tags

}