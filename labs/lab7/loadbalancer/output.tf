output "lb_dns" {
  description = "this is the loadbalancer dns name"
  value       = aws_lb.frontend.dns_name
}