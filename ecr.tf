/*resource "aws_ecr_repository" "image-repo" {
  name                 = "techieirfan"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.ecrrepo
    Environment = "dev"
  }
}*/