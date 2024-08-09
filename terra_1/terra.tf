provider "aws" {
    region = "region"

}
resource "aws_instance" "demo" {
  ami = "instance_id"
  
}