provider "aws" {
    region = "region"

}
resource "aws_instance" "demo" {
  ami = "ami-0ad21ae1d0696ad58"
  instance_type = "t3.micro"
  key_name = "b37-1"

  tags = {
    name = "instance_name"
  }
}