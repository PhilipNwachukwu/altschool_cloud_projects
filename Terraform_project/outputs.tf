output "instance_ips" {
  value = [
    aws_instance.web_server[0].public_ip,
    aws_instance.web_server[1].public_ip,
    aws_instance.web_server[2].public_ip,
  ]
}

# output "server2_public_ip" {
#   value = aws_instance.web_server2.public_ip
# }

# output "server3_public_ip" {
#   value = aws_instance.web_server3.public_ip
# }

output "aws_lb_public_dns" {
  value = aws_lb.apache.dns_name
}
