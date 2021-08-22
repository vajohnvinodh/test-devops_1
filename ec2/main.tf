provider "aws" {
        region = "us-east-1"
}



resource "aws_instance" "myec2" {
  ami           = "ami-0dc2d3e4c0f9ebd18"
  instance_type = "${var.server_type}"
#  security_groups = ["opentoworld"]
  key_name = "${var.keypair_name}"
  tags = { "Name": "${var.servername}" }
  count = 1
  subnet_id = "${var.subnetid}"
  vpc_security_group_ids = ["${var.secgroupid}"]
  associate_public_ip_address = true
}
