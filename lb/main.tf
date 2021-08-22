provider "aws" {

        region = "us-east-1"
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.secgroupid}"]
  subnets            = "${var.subnetid1}"
#  availability_zones = ["us-west-1b", "us-west-1c"] 

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "targetgp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpcid}"
  target_type = "instance"
}
