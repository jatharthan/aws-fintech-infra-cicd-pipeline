# -------------------
# VPC
# -------------------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# # -------------------
# # Public Subnets
# # -------------------
# output "public_subnet_ids" {
#   description = "List of public subnet IDs"
#   value       = aws_subnet.public[*].id
# }

# # -------------------
# # Private Subnets
# # -------------------
# output "private_subnet_ids" {
#   description = "List of private subnet IDs"
#   value       = aws_subnet.private[*].id
# }

# # -------------------
# # Security Groups
# # -------------------
# output "ec2_sg_id" {
#   description = "Security Group ID for EC2 instances"
#   value       = aws_security_group.ec2_sg.id
# }

# output "alb_sg_id" {
#   description = "Security Group ID for ALB"
#   value       = aws_security_group.alb_sg.id
# }
