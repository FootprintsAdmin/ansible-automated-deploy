resource "aws_instance" "logstash" {
  ami = "ami-c481fad3"
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true
  key_name = "aws"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.logstash_sg.id}"]
}

output "logstash.dns_name" {
  value = "${aws_instance.logstash.dns_name}"
}

output "logstash.private_ip" {
  value = "${aws_instance.logstash.private_ip}"
}
