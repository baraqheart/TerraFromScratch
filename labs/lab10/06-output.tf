


output "lb_dns" {
  description = "this is the loadbalancer dns name"
  value       = aws_lb.frontend.dns_name
}


output "ecs_cluster_name" {
  description = "this the cluster name"
  value       = aws_ecs_cluster.cluster1.id
}

output "ecs_service_name" {
  description = " this is thte service name"
  value       = aws_ecs_service.service1.name
}

output "private_subnet1_id" {
  description = "this the id of the private subnet in zone 1"
  value       = aws_subnet.private_zone1.id
}

output "private_subnet2_id" {
  description = "this the id of the private subnet in zone 2"
  value       = aws_subnet.private_zone2.id
}

