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

resource "aws_instance" "master" {
  ami                         = var.AMIS[var.AWS_REGION]
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.Demo-kube-master-sg.id, aws_security_group.Demo-kube-mutual-sg.id]

  # the public SSH key
  key_name  = aws_key_pair.ssh_key.key_name # Use the created key pair for SSH access
  user_data = local.master_template

  tags = {
    Name                            = "kube-master"
    "kubernetes.io/cluster/kubeadm" = "owned"
    Role                            = "master"
    type                            = "terraform"
  }
}

resource "aws_instance" "worker" {
  count         = 1
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.Demo-kube-worker-sg.id, aws_security_group.Demo-kube-mutual-sg.id]

  # the public SSH key
  key_name  = aws_key_pair.ssh_key.key_name
  user_data = local.worker_template

  tags = {
    Name                            = "kube-worker"
    "kubernetes.io/cluster/kubeadm" = "owned"
    Role                            = "worker"
    type                            = "terraform"
    created                         = "terraform"
  }
}

locals {
  master_template = templatefile("./master.tpl", {})
  worker_template = templatefile("./worker.tpl", {})
}

