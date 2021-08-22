output "subnetid" {

	value = "${aws_subnet.pubsub.id}"
}

output "subnetid1" {

        value = ["${aws_subnet.pubsub1.id}", "${aws_subnet.pubsub.id}"]
}


output "secgroupid" {

	value = "${aws_security_group.publicsec.id}"

}

output "mypvtsecgroupid" {

        value = "${aws_security_group.pvtsec.id}"

}


output "mysubgrouid" {

        value = "${aws_db_subnet_group.subgroup.id}"

}

output "vpcid" {

        value = "${aws_vpc.myvpc.id}"

}

output "subnetid_1" {

        value = "${aws_subnet.pubsub.*.id}"
}
