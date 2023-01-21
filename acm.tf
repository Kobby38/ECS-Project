resource "aws_acm_certificate" "e-learning" {
  domain_name = "kwabenayeboahopoku.com"
  validation_method = "DNS"
}

data "aws_route53_zone" "e-learning" {
  name = "kwabenayeboahopoku.com"
  private_zone = false
}

resource "aws_route53_record" "e-learning" {
  for_each = {
    for dvo in aws_acm_certificate.e-learning.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = data.aws_route53_zone.e-learning.zone_id
}

resource "aws_acm_certificate_validation" "e-learning" {
  certificate_arn = aws_acm_certificate.e-learning.arn
  validation_record_fqdns = [for record in aws_route53_record.e-learning : record.fqdn]
}

