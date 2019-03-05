output "MGT-IP-FW-1" {
  value = "${aws_eip.FW1-MGT.public_ip}"
}

output "NLB-DNS" {
  value = "${aws_lb.int-nlb.dns_name}"
}

output "ALB-DNS" {
  value = "${aws_lb.ext-alb.dns_name}"
}
