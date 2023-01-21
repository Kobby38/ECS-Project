resource "aws_route53_record" "ecsapp" {
  zone_id         = data.aws_route53_zone.e-learning.zone_id
  name            = "kwabenayeboahopoku.com"
  type            = "A"

  alias {
    name          = aws_lb.application_alb.dns_name
    zone_id       = aws_lb.application_alb.zone_id
    evaluate_target_health = true
  }
}