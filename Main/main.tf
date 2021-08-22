module "server" {
	
	source = "/root/ec2"
	server_type = "t2.micro"
	env = "test"
	keypair_name = "John_Keypair"
	servername = "test-devops"
	subnetid = "${module.network.subnetid}"
	secgroupid = "${module.network.secgroupid}"
}

module "network" {
	source = "/root/vpc"
	region = "us-east-1"
	vpc_cidr = "192.150.0.0/16"
	vpc_name = "test-devops"
	igw_name = "test-igw"
	sub_publicroute = "test-pubroute"
	pubsub_cidr = "192.150.10.0/24"
	pubsub_name = "test-pubsub"
        pubsub_cidr1 = "192.150.11.0/24"
        pubsub_name1 = "test-pubsub1"
	sub_pvtroute = "test-pvtroute"
	pvtsub_cidr = "192.150.20.0/24"
	pvtsub_name = "test-pvtsub"
	pvtsub1_cidr = "192.150.21.0/24"
	pvtsub1_name = "test-pvtsub1"
}

module "db" { 
	source = "/root/rds"
	mysubgrouid = "${module.network.mysubgrouid}"
	mypvtsecgroupid = "${module.network.mypvtsecgroupid}"
}

module "lb" {

	source = "/root/lb"
	secgroupid = "${module.network.secgroupid}"
	subnetid1 = "${module.network.subnetid1}"
	vpcid = "${module.network.vpcid}"
}
