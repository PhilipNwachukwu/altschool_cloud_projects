# Route53 Hosted Zone
resource "aws_route53_zone" "apache" {
  name = "philipnwachukwu.ml"
}

# Route53 Records
resource "aws_route53_record" "ns" {
  allow_overwrite = true
  name            = "philipnwachukwu.ml"
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.apache.zone_id

  records = [
    aws_route53_zone.apache.name_servers[0],
    aws_route53_zone.apache.name_servers[1],
    aws_route53_zone.apache.name_servers[2],
    aws_route53_zone.apache.name_servers[3],
  ]
}

# resource "aws_route53_record" "soa" {
#   allow_overwrite = true
#   name            = "philipnwachukwu.ml"
#   ttl             = 900
#   type            = "SOA"
#   zone_id         = aws_route53_zone.apache.zone_id

#   records = [var.soa_server]
# }

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.apache.zone_id
  name    = "www.philipnwachukwu.ml"
  type    = "CNAME"
  ttl     = 3600
  records = [aws_lb.apache.dns_name]
}


# Alias Record
resource "aws_route53_record" "apache" {
  zone_id = aws_route53_zone.apache.zone_id
  name    = "philipnwachukwu.ml"
  type    = "A"

  alias {
    name                   = aws_lb.apache.dns_name
    zone_id                = aws_lb.apache.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "terraform-test" {
  zone_id = aws_route53_zone.apache.zone_id
  name    = "terraform-test.philipnwachukwu.ml"
  type    = "A"

  alias {
    name                   = aws_lb.apache.dns_name
    zone_id                = aws_lb.apache.zone_id
    evaluate_target_health = true
  }
}
