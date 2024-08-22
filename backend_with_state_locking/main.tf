# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-dcube"
#     region         = "us-west-2"
#     dynamodb_table = "terraform_state_lock"
#     key            = "dev/ec2.tfstate"
#     encrypt        = true
#   }
# }