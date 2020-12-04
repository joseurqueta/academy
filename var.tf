variable "aws-region" {
    default = "us-east-1"
}

variable "ami" {
       default = "ami-04d29b6f966df1537"
            }

variable "instance_type" {
    description = "Instance type"
    default = "t1.micro"
}

variable "key_path" {
    description = "SSH Public Key"
    default = "ju-key"
}

variable "user_data" {
    description = "User data installing httpd"
    default = <<EOF
#!/bin/bash
yum install httpd -y
systemctl start httpd
systemctl stop firewalld
sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html
EOF

}
