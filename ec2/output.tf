output "ec2id" {

        value = "${aws_instance.myec2.*.id}"

}
