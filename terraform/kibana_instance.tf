resource "aws_instance" "kibana" {
  ami = "ami-c481fad3"
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true
  key_name = "footprints-client"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.kibana_sg.id}"]
}

output "kibana.private_ip" {
  value = "${aws_instance.kibana.private_ip}"
}
