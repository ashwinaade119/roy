provider "aws" {
  region = "ap-south-1"
}

module "my_key_pair" {
  source     = "./modules/key_pair" # Path to the module directory
  key_name   = "ashwin"
  public_key = file("${path.module}/./modules/key_pair/hybrid.pub") # Ensure this file exists and contains your public key

  tags = {
    Environment = "production"
    Owner       = "jarvis"
  }
}


module "my_ec2_instance" {
  source          = "./modules/ec2_instance" # Path to the EC2 instance module directory
  ami             = "ami-02b49a24cfb95941c" # Replace with your desired AMI
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

