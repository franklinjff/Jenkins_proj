aws_region = "AWS Rehion Here"

ServerKeyName = "AWS Regional Keypair"

bootstrap_s3bucket = "S3 Bootstrap Name"

aws_access_key = "API Access Key Here"

aws_secret_key = "API Secret Key Here"

waf_prefix = "managed"

blacklisted_ips = [
  {
    value = "172.16.0.0/16"

    type = "IPV4"
  },
  {
    value = "192.168.0.0/16"

    type = "IPV4"
  },
  {
    value = "169.254.0.0/16"

    type = "IPV4"
  },
  {
    value = "127.0.0.1/32"

    type = "IPV4"
  },
  {
    value = "10.0.0.0/8"

    type = "IPV4"
  },
]

admin_remote_ipset = [
  {
    value = "127.0.0.1/32"

    type = "IPV4"
  },
]

alb_arn = "aws_lb.ext-alb.arn"
