terraform {
   required_providers {
     aws = {
       source  = "hashicorp/aws"
     }
   }
 }

 provider "aws" {
   region = "ap-south-1"
 }

 resource "aws_s3_bucket" "terraform-state" {
   bucket = "terraform-state-dcube-21234"
 }

 resource "aws_s3_bucket_versioning" "terraform-state" {
   bucket = aws_s3_bucket.terraform-state.id
   versioning_configuration {
     status = "Enabled"
   }
 }