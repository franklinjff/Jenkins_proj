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
  instance_type                        = "m5.large"
  key_name                             = "${var.ServerKeyName}"
  monitoring                           = false

  tags {
    Name = "kali"
  }

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.kali-int.id}"
  }

  user_data = "${base64encode(join("", list(
      "#! /bin/bash\n",
          "sudo su\n",
          "apt-get update\n",
          "apt install docker.io python3-pip -y --force-yes\n",
          "pip3 install docker-compose\n",
          "cd /var/tmp\n",
          "wget https://jff-jenkins-attack.s3-us-west-2.amazonaws.com/Dockerfile\n",
          "wget https://jff-jenkins-attack.s3-us-west-2.amazonaws.com/docker-compose.yml\n",
          "wget https://jff-jenkins-attack.s3-us-west-2.amazonaws.com/run.sh\n",
          "wget https://jff-jenkins-attack.s3-us-west-2.amazonaws.com/auto-sploit.sh\n",
          "docker-compose build\n",
          "docker-compose up -d\n"
    )))
   }"
}
