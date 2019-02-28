output "MGT-IP-FW-1" {
  value = "${aws_eip.FW1-MGT.public_ip}"
}

#output "MGT-IP-FW1-IF" {
#value = "${aws_network_interface.FW1-UNTRUST.private_ips[0]}"
#}

#output "MGT-IP-FW-2" {
#  value = "${aws_eip.FW2-MGT.public_ip}"
#}

#output "MGT-IP-FW2-IF" {
#value = "${aws_network_interface.FW2-UNTRUST.private_ips[0]}"
#}

output "NLB-DNS" {
  value = "${aws_lb.int-nlb.dns_name}"
}

output "ALB-DNS" {
  value = "${aws_lb.ext-alb.dns_name}"
}
