provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "footprints_elk_vpc" {
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = "${aws_vpc.footprints_elk_vpc.id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/26"
}

resource "aws_internet_gateway" "footprints_gateway" { vpc_id = "${aws_vpc.footprints_elk_vpc.id}" }

resource "aws_route_table" "footprints_route_table" {
  vpc_id = "${aws_vpc.footprints_elk_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.footprints_gateway.id}"
  }
}

resource "aws_route_table_association" "route_subnet_1" {
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.footprints_route_table.id}"
}

resource "aws_security_group" "master_sg" {
  vpc_id = "${aws_vpc.footprints_elk_vpc.id}"

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "elasticsearch_sg" {
  vpc_id = "${aws_vpc.footprints_elk_vpc.id}"

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ "${aws_security_group.master_sg.id}" ]
  }

  ingress {
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    security_groups = [ "${aws_security_group.logstash_sg.id}", "${aws_security_group.kibana_sg.id}" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "kibana_sg" {
  vpc_id = "${aws_vpc.footprints_elk_vpc.id}"

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ "${aws_security_group.master_sg.id}" ]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "logstash_sg" {
  vpc_id = "${aws_vpc.footprints_elk_vpc.id}"

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ "${aws_security_group.master_sg.id}" ]
  }

  ingress {
    from_port = 9600
    to_port = 9700
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
