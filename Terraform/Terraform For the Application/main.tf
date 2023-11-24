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
  tags = {
    Name = "Capstone - React App"
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
      "sudo mkdir /opt/docker-container/",
      "sudo chown -R ubuntu:ubuntu /opt/docker-container/"
    ]
  }

  provisioner "file" {
    source      = "files/"
    destination = "/opt/docker-container/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /opt/docker-container/docker-compose.sh",
      "sudo chmod +x /opt/docker-container/Install.sh",
      "sudo chmod +x /opt/docker-container/node_exporter.sh",
      "cd /opt/docker-container/",
      "sudo bash Install.sh",
      "sudo bash node_exporter.sh",
      "./docker-compose.sh"      
    ]
  }
}

output "ec2_public_ip" {
  depends_on = [aws_instance.terraform_ec2]
  value      = aws_instance.terraform_ec2.public_ip
}