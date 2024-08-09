provider "aws" {
    region = "region"

}
resource "aws_instance" "demo" {
  ami = "instance_id"
  instance_type = "t3.micro"
  key_name = ""
}