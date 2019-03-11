##--- VPC ----

resource "aws_vpc" "tower_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "tower_vpc_gk"
  }
}

##Internet Gateway

resource "aws_internet_gateway" "tower_igw" {
  vpc_id = "${aws_vpc.tower_vpc.id}"

  tags {
    Name = "tower_igw_gk"
  }
}

## Route tables

resource "aws_route_table" "tower_public_rt" {
    vpc_id = "${aws_vpc.tower_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.tower_igw.id}"
    }

    tags {
        Name = "tower_rt_gk"
    }
}

##Subnets

resource "aws_subnet" "tower_pub_subnet" {
    vpc_id = "${aws_vpc.tower_vpc.id}"
    cidr_block = "${var.cidrs["public"]}"
    map_public_ip_on_launch = true
    availability_zone = "${data.aws_availability_zones.available.names[0]}"

    tags {
        Name = "tower_public_sn_gk"
    }

}

#subnet associations
resource "aws_route_table_association" "public_association" {
  subnet_id = "${aws_subnet.tower_pub_subnet.id}"
  route_table_id = "${aws_route_table.tower_public_rt.id}"
}

