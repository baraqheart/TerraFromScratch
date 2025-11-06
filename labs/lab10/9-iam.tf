resource "aws_iam_role" "ecs" {
  name = "ecs_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AllowECSToAssumeThisRole"
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${local.project}-ecs-role"
  }
}



resource "aws_iam_role_policy" "ecs" {
  name = "test_policy"
  role = aws_iam_role.ecs.id


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ecs:CreateCluster",
          "ecs:ListClusters"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}



