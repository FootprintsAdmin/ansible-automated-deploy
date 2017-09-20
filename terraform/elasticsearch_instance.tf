resource "aws_instance" "elasticsearch" {
  ami = "ami-c481fad3"
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true
  key_name = "footprints-client"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.elasticsearch_sg.id}"]
}

output "elasticsearch.private_ip" {
  value = "${aws_instance.elasticsearch.private_ip}"
}

output "elasticsearch.dns" {
  value = "${aws_instance.elasticsearch.public_dns}"
}
