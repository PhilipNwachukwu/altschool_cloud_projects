
# INSTANCES #

resource "aws_instance" "web_server" {
  count                  = 3
  ami                    = data.aws_ami.debian-11.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.apache-sg.id]
  key_name               = aws_key_pair.key_pair.key_name

  tags = local.common_tags

}

resource "null_resource" "remote-exec" {
  depends_on = [
    aws_instance.web_server
  ]
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = aws_instance.web_server[0].public_ip
      type        = "ssh"
      user        = "admin"
      private_key = file("/root/.ssh/${aws_key_pair.key_pair.key_name}.pem")
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = aws_instance.web_server[1].public_ip
      type        = "ssh"
      user        = "admin"
      private_key = file("/root/.ssh/${aws_key_pair.key_pair.key_name}.pem")
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = aws_instance.web_server[2].public_ip
      type        = "ssh"
      user        = "admin"
      private_key = file("/root/.ssh/${aws_key_pair.key_pair.key_name}.pem")
    }
  }

  # provisioner "local-exec" {
  #   command = "export ANSIBLE_CONFIG=./ansible.cfg"
  # }

  provisioner "local-exec" {
    # command = "ansible webserver -m shell -a 'main.yml'"

    # provisioner "local-exec" {
    command = "ansible-playbook -u admin -i ${local_file.instance_ip.filename} --private-key ${local_file.ssh_key.filename} main.yml"
  }
}

resource "local_file" "instance_ip" {
  depends_on = [
    aws_instance.web_server
  ]
  content = <<EOT
      [webserver]
      %{for host, ip in aws_instance.web_server.*.public_ip~}
      ${ip} 
      %{endfor~}
    EOT  

  filename = "/vagrant/altschool_cloud_projects/Terraform_project/host-inventory"
}

