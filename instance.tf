resource "aws_instance" "ju-ins-tf" {
  ami = ""
  instance_type = ""
}


resource "aws_instance" "ju-ins1-tf" {
  ami = "${lookup(var.ami , var.aws-region}"
  instance_type = "t2.micro"
  # VPC
  subnet_id = aws_subnet.ju-sub-pub.id
  # Security Group
  vpc_security_group_ids = aws_security_group.ju-ssh-tf.id
  # the Public SSH key
  key_name = aws_key_pair.ju-key.id
  # nginx installation
  provisioner "file" {
    source = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }
  connection {
    user = "${var.EC2_USER}"
    private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
  }
}
// Sends your public key to the instance
resource "aws_key_pair" "london-region-key-pair" {
  key_name = "london-region-key-pair"
  public_key = "${file(var.PUBLIC_KEY_PATH)}"
}