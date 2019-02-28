resource "aws_network_interface" "web1-int" {
  subnet_id         = "${aws_subnet.AZ1-TRUST.id}"
  security_groups   = ["${aws_security_group.sgWideOpen.id}"]
  source_dest_check = false
  private_ips       = ["${var.WebSRV1_AZ1_Trust}"]
}

resource "aws_instance" "web1" {
  instance_initiated_shutdown_behavior = "stop"
  ami                                  = "${var.UbuntuRegionMap[var.aws_region]}"
  instance_type                        = "m3.large"
  key_name                             = "${var.ServerKeyName}"
  monitoring                           = false

  tags {
    Name = "WEB-AZ1"
  }

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.web1-int.id}"
  }

  user_data = "${base64encode(join("", list(
   "#! /bin/bash\n",
          "sudo su\n",
          "add-apt-repository ppa:openjdk-r/ppa -y\n",
          "apt-get update\n",
          "apt-get install openjdk-7-jre-headless -y\n",
          "cd /var/tmp\n",
          "wget https://jenkins-test-vuln.s3-us-west-2.amazonaws.com/jenkins.tgz\n",
          "tar zxf jenkins.tgz\n",
          "cd /opt\n",
          "mkdir jenkins\n",
          "cd jenkins\n",
          "wget https://s3.amazonaws.com/jenkinsploit/jenkins-2-32.war\n",
          "chmod +x jenkins-2-32.war\n",
          "export JENKINS_HOME=/var/tmp/.jenkins\n",
          "nohup java -jar jenkins-2-32.war &\n"
   )))
   }"
}

#resource "aws_network_interface" "web2-int" {
#  subnet_id         = "${aws_subnet.AZ2-TRUST.id}"
#  security_groups   = ["${aws_security_group.sgWideOpen.id}"]
#  source_dest_check = false
#  private_ips       = ["${var.WebSRV2_AZ2_Trust}"]
#}


#resource "aws_instance" "web2" {
#  instance_initiated_shutdown_behavior = "stop"
#  ami                                  = "${var.UbuntuRegionMap[var.aws_region]}"
#  instance_type                        = "m3.large"
#  key_name   = "${var.ServerKeyName}"
#  monitoring = false


#  tags {
#    Name = "WEB-AZ2"
#  }


#  network_interface {
#    device_index         = 0
#    network_interface_id = "${aws_network_interface.web2-int.id}"
#  }


#  user_data = "${base64encode(join("", list(
#    "#! /bin/bash\n",
#            "echo Webserver2 > index.html && nohup busybox httpd -f -p 80"
#    )))
#    }"
#}

