output "vpc_id" { value = aws_vpc.main.id }
output "public_subnets" { value = aws_subnet.public[*].id }
output "private_subnets" { value = aws_subnet.private[*].id }
output "alb_dns_name" { value = aws_lb.alb.dns_name }
output "rds_endpoint" { value = aws_db_instance.rds.endpoint }
output "s3_bucket_name" { value = aws_s3_bucket.static_assets.id }
output "asg_name" { value = aws_autoscaling_group.asg.name }
