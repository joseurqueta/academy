resource "aws_vpc" "ju-vpc-tf" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"

  tags = {
    name = "ju-vpc-tf"
  }
}
#subnet
resource "aws_subnet" "ju-sub-pub" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.ju-vpc-tf.id
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    name = "ju-sub-pub"
  }
}
resource "aws_subnet" "ju-sub-pub2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.ju-vpc-tf.id
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = {
    name = "ju-sub-pub2"
  }
}