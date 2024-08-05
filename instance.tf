### VPC module to create vpc

locals {
  region = var.AWS_REGION
}

data "aws_vpc" "default" {
  default = true
}

# Create Key Pair for SSH access
resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform_key"
  public_key = file("./my-aws-keypair.pub") # Change path accordingly
}

resource "aws_instance" "jenkins" {
  ami                         = var.AMIS[var.AWS_REGION]
  instance_type               = var.instance_type
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.combined_instance_profile.name

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.webserver-sg.id]

  # the public SSH key
  key_name  = aws_key_pair.ssh_key.key_name # Use the created key pair for SSH access
  user_data = local.jenkins_file_int

  tags = {
    Name    = "jenkins"
    Role    = "app"
    type    = "terraform"
    created = "terraform"
  }
}

resource "aws_instance" "webserver" {
  ami                  = var.AMIS[var.AWS_REGION]
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.combined_instance_profile.name

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.webserver-sg.id]

  # the public SSH key
  key_name  = aws_key_pair.ssh_key.key_name
  user_data = local.template_file_int

  tags = {
    Name    = "automation-server"
    Role    = "app"
    type    = "terraform"
    created = "terraform"
  }
}

locals {
  template_file_int = templatefile("./install.tpl", {})
  jenkins_file_int = templatefile("./jenkins.tpl", {})
}


