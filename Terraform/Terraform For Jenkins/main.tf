# Retreive Key:
data "aws_key_pair" "terraform_key" {
  key_name           = "test"
  include_public_key = true
}

# EC2 for Jenkins:
resource "aws_instance" "terraform_ec2" {
  ami           = var.ec2[0]
  instance_type = var.ec2[1]
  tenancy       = var.ec2[2]
  key_name      = data.aws_key_pair.terraform_key.key_name
  root_block_device {
    volume_size = "15"
  }
  tags = {
    Name = "Jenkins"
    Env  = "Testing"
  }
}

resource "null_resource" "terraform_copy" {
  depends_on = [
    aws_instance.terraform_ec2,
  ]
  triggers = {
    always-trigger = timestamp()
  }

  connection {
    type        = "ssh"
    host        = aws_instance.terraform_ec2.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("key/test.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /opt/jenkins/",
      "sudo mkdir /opt/jenkins/prometheus/",
      "sudo mkdir /opt/jenkins/alertmanager/",
      "sudo chown -R ubuntu:ubuntu /opt/jenkins"
    ]
  }

  provisioner "file" {
    source      = "scripts/"
    destination = "/opt/jenkins/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /opt/jenkins/Jenkins.sh",
      "sudo chmod +x /opt/jenkins/Install.sh",
      "sudo chmod +x /opt/jenkins/prometheus.sh",
      "cd /opt/jenkins/",
      "sudo bash Jenkins.sh",
      "sudo -u jenkins sudo bash Install.sh",
      "cp /opt/jenkins/alertmanager.yml alertmanager/",
      "cp /opt/jenkins/alert_rules.yml prometheus.yml prometheus/",
      "sudo bash prometheus.sh",
    ]
  }
}

output "ec2_public_ip" {
  depends_on = [aws_instance.terraform_ec2]
  value      = aws_instance.terraform_ec2.public_ip
}