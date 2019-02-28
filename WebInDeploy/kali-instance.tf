resource "aws_network_interface" "kali-int" {
  subnet_id         = "${aws_subnet.AZ1-attack1.id}"
  security_groups   = ["${aws_security_group.kaliWideOpen.id}"]
  source_dest_check = false
  private_ips       = ["${var.kali_AZ1_attack}"]
}
resource "aws_eip_association" "kali-Association" {
  network_interface_id = "${aws_network_interface.kali-int.id}"
  allocation_id        = "${aws_eip.kali.id}"
}
resource "aws_instance" "kali" {
  instance_initiated_shutdown_behavior = "stop"
  ami                                  = "${var.kali[var.aws_region]}"
  instance_type                        = "m3.large"
  key_name                             = "${var.ServerKeyName}"
  monitoring                           = false

  tags {
    Name = "kali"
  }

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.kali-int.id}"
  }

  #user_data = "${base64encode(join("", list(
  #"#! /bin/bash\n",
}
