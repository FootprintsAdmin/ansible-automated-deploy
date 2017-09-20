resource "aws_instance" "master_chief" {
  ami = "ami-c481fad3"
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true
  key_name = "footprints-master"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.master_sg.id}"]
}

output "master_chief.private_ip" {
  value = "${aws_instance.master_chief.private_ip}"
}

output "master_chief.public_ip" {
  value = "${aws_instance.master_chief.public_ip}"
}

output "master_chief.dns" {
  value = "${aws_instance.master_chief.public_dns}"
}
