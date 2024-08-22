# Note: 
# 1. ec2_instance module is not supposed to manage a security group for creation.
# 2. If the security group is managed outside the ec2_instance module, you don't need to reference it within this module.
# Just remove the output.tf file entirely

# Instead of this we can call the instance-id


output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}


