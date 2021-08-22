provider "aws" {

        region = "${var.region}"
}

resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "${var.igw_name}"
  }
}
resource "aws_route_table" "pubroute" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route  {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.myigw.id}"
    }

  tags = {
    Name = "${var.sub_publicroute}"
  }
}
resource "aws_subnet" "pubsub" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.pubsub_cidr}"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.pubsub_name}"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.pubsub_cidr1}"
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.pubsub_name1}"
  }
}

resource "aws_route_table_association" "publicassoc" {
  subnet_id      = "${aws_subnet.pubsub.id}"
  route_table_id = "${aws_route_table.pubroute.id}"
}

resource "aws_route_table_association" "publicassoc1" {
  subnet_id      = "${aws_subnet.pubsub1.id}"
  route_table_id = "${aws_route_table.pubroute.id}"
}

resource "aws_route_table" "pvtroute" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "${var.sub_pvtroute}"
  }
}
resource "aws_subnet" "pvtsub" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.pvtsub_cidr}"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.pvtsub_name}"
  }
}
resource "aws_subnet" "pvtsub1" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.pvtsub1_cidr}"
  availability_zone = "us-east-1e"
  tags = {
    Name = "${var.pvtsub1_name}"
  }
}
resource "aws_route_table_association" "pvtassoc" {
  subnet_id      = "${aws_subnet.pvtsub.id}"
  route_table_id = "${aws_route_table.pvtroute.id}"
}

resource "aws_route_table_association" "pvtassoc1" {
  subnet_id      = "${aws_subnet.pvtsub1.id}"
  route_table_id = "${aws_route_table.pvtroute.id}"
}

resource "aws_security_group" "publicsec" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.myvpc.id}"

  ingress = [
    {
      description      = "Http VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
	 description = "Defining external rules"
      "ipv6_cidr_blocks": null
                        "prefix_list_ids": null
                      
                        "security_groups": null
			"self":null
},
	{
      description      = "SSH to VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
	 description = "Defining external rules"
      "ipv6_cidr_blocks": null
                        "prefix_list_ids": null

                        "security_groups": null
                        "self":null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
	description = "null"
      "ipv6_cidr_blocks": null
                        "prefix_list_ids": null

                        "security_groups": null
                        "self":null
    }
  ]

  tags = {
    Name = "publicsec"
  }
}
resource "aws_security_group" "pvtsec" {
  name        = "allow_mysql"
  description = "Allow mysql inbound traffic"
  vpc_id      = "${aws_vpc.myvpc.id}"

  ingress = [
    {
      description      = "mysql"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
 description = "Defining external rules"
      "ipv6_cidr_blocks": null
                        "prefix_list_ids": null

                        "security_groups": null
                        "self":null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
	description = null
      "ipv6_cidr_blocks": null
                        "prefix_list_ids": null

                        "security_groups": null
                        "self":null
    }
  ]

  tags = {
    Name = "pvtsec"
  }
}

resource "aws_db_subnet_group" "subgroup" {
  name       = "testgroup1"
  subnet_ids = [aws_subnet.pvtsub.id,aws_subnet.pvtsub1.id]


  tags = {
    Name = "My DB subnet group"
  }

}
