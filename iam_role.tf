# Create an IAM Role
resource "aws_iam_role" "ecr_role" {
  name = "ecr_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the ECR policy to the role
resource "aws_iam_role_policy" "ecr_policy" {
  name   = "ecr_policy"
  role   = aws_iam_role.ecr_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:CreateRepository",
          "ecr:DeleteRepository",
          "ecr:DeleteRepositoryPolicy",
          "ecr:DescribeImages",
          "ecr:GetRepositoryPolicy",
          "ecr:ListTagsForResource",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy",
          "ecr:DescribeImageScanFindings",
          "ecr:StartImageScan",
          "ecr:StartLifecyclePolicyPreview",
          "ecr:DeleteLifecyclePolicy",
          "ecr:GetLifecyclePolicy",
          "ecr:PutLifecyclePolicy",
          "ecr:DescribePullThroughCacheRules",
          "ecr:CreatePullThroughCacheRule",
          "ecr:DeletePullThroughCacheRule",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:DescribeReplicationConfigurations",
          "ecr:PutReplicationConfiguration"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the role to an instance profile
resource "aws_iam_instance_profile" "ecr_instance_profile" {
  name = "ecr_instance_profile"
  role = aws_iam_role.ecr_role.name
}

