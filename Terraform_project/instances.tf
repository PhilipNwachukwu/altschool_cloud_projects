
# INSTANCES #

resource "aws_instance" "web_server" {
  count                  = 3
  ami                    = data.aws_ami.debian-11.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.apache-sg.id]

  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
echo "<html><head><title>Server 1</title></head><body><h1>Welcome to Alschool Web-app 1</h1></body>
</html>" > /var/www/html/index.html
sudo systemctl restart apache2
EOF

  tags = local.common_tags

}

# resource "aws_instance" "web_server1" {
#   ami                    = data.aws_ami.debian-11.id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.subnet1.id
#   vpc_security_group_ids = [aws_security_group.apache-sg.id]

#   user_data = <<EOF
# #! /bin/bash
# sudo apt-get update
# sudo apt-get install -y apache2
# sudo systemctl start apache2
# echo "<html><head><title>Server 1</title></head><body><h1>Welcome to Alschool Web-app 1</h1></body>
# </html>" > /var/www/html/index.html
# sudo systemctl restart apache2
# EOF

#   tags = local.common_tags
# }

# resource "aws_instance" "web_server2" {
#   ami                    = data.aws_ami.debian-11.id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.subnet2.id
#   vpc_security_group_ids = [aws_security_group.apache-sg.id]

#   user_data = <<EOF
# #! /bin/bash
# sudo apt-get update
# sudo apt-get install -y apache2
# sudo systemctl start apache2
# echo "<html><head><title>Server 2</title></head><body><h1>Welcome to Alschool Web-app 2</h1></body>
# </html>" > /var/www/html/index.html
# sudo systemctl restart apache2
# EOF

#   tags = local.common_tags
# }

# resource "aws_instance" "web_server3" {
#   ami                    = data.aws_ami.debian-11.id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.subnet3.id
#   vpc_security_group_ids = [aws_security_group.apache-sg.id]

#   user_data = <<EOF
# #! /bin/bash
# sudo apt-get update
# sudo apt-get install -y apache2
# sudo systemctl start apache2
# echo "<html><head><title>Server 3</title></head><body><h1>Welcome to Alschool Web-app 3</h1></body>
# </html>" > /var/www/html/index.html
# sudo systemctl restart apache2
# EOF

#   tags = local.common_tags
# }

resource "local_file" "instance_ips_1" {
  content = <<EOT
      $[webserver]
      %{for host, ip in aws_instance.web_server.*.public_ip~}
      ${ip}
      %{endfor~}
      $[webserver:vars]
    EOT  

  filename = "/vagrant/Terraform/altschool_web_app/ansible/host-inventory"
}

