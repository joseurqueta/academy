resource "aws_internet_gateway" "ju-ig-tf" {
  vpc_id = aws_vpc.ju-vpc-tf.id

  tags = {
    Name = "ju-igw-tf"
  }
}
#route table
resource "aws_route_table" "ju-rt1-tf" {
  vpc_id = aws_vpc.ju-vpc-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ju-ig-tf.id
  }
  tags = {
    name = "ju-rt1-tf"
  }
}
#crt

resource "aws_route_table_association" "ju-crt-pub1-tf" {
  route_table_id = aws_route_table.ju-rt1-tf.id
  subnet_id = aws_subnet.ju-sub-pub.id
}
resource "aws_route_table_association" "ju-crt-pub2-tf" {
  route_table_id = aws_route_table.ju-rt1-tf.id
  subnet_id = aws_subnet.ju-sub-pub2.id
}
resource "aws_security_group" "ju-ssh-tf" {
  vpc_id = aws_vpc.ju-vpc-tf.id

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    protocol = "icmp"
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ju-ssh-tf"
  }

}
