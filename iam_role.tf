# Create a combined IAM Role for EC2 with ECR, ECS, and Lambda S3 permissions
resource "aws_iam_role" "combined_role" {
  name = "combined_role"

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

# Attach the combined policy to the role
resource "aws_iam_role_policy" "combined_policy" {
  name   = "combined_policy"
  role   = aws_iam_role.combined_role.id

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
          "ecr:PutReplicationConfiguration",
          "ecr:GetAuthorizationToken",
          "ecs:CreateCluster",
          "ecs:DeregisterContainerInstance",
          "ecs:DiscoverPollEndpoint",
          "ecs:Poll",
          "ecs:RegisterContainerInstance",
          "ecs:StartTelemetrySession",
          "ecs:UpdateContainerInstancesState",
          "ecs:Submit*",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the role to an instance profile
resource "aws_iam_instance_profile" "combined_instance_profile" {
  name = "combined_instance_profile"
  role = aws_iam_role.combined_role.name
}