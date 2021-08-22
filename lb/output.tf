output "lbid" {

        value = "${aws_lb.test.id}"
}

output "target_group_arn" {

        value = "${aws_lb.test.arn}"
}
