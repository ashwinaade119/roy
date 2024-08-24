provider "aws" {
  region = "ap-south-1"
}

module "my_key_pair" {
  source     = "./modules/key_pair" # Path to the module directory
  key_name   = "supreme_key"
  public_key = file("${path.module}/./modules/key_pair/hybrid.pub") # Ensure this file exists and contains your public key

  tags = {
    Environment = "production"
    Owner       = "jarvis"
  }
}

module "my_security_group" {
  source      = "./modules/security_group" # Path to the module directory
  name        = "my-security-group"
  description = "Security group for my application"
  vpc_id      = "vpc-0efd68799627244ca"  # Replace with your VPC ID

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]

  tags = {
    Environment = "production"
    Owner       = "jarvis"
  }
}

module "my_ec2_instance" {
  source          = "./modules/ec2_instance" # Path to the EC2 instance module directory
  ami             = "ami-0ad21ae1d0696ad58" # Replace with your desired AMI
  instance_type   = "t2.medium"
  key_name        = module.my_key_pair.key_name
  vpc_security_group_ids = [module.my_security_group.security_group_id]
  user_data_file  = "${path.module}/./modules/ec2_instance/nginx_setup.sh"

  tags = {
    Name        = "MyWebServer"
    Environment = "production"
    Owner       = "jarvis"
  }
}

