terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "input" {
  bucket = var.s3_input_bucket
}

resource "aws_s3_bucket" "output" {
  bucket = var.s3_output_bucket
}

resource "aws_iam_role" "lambda_role" {
  name = "serverless-data-pipeline-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "pipeline" {
  function_name = "serverless-data-pipeline-handler"
  filename      = var.lambda_zip_path
  runtime       = "python3.11"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
}

resource "aws_s3_bucket_notification" "input_notification" {
  bucket = aws_s3_bucket.input.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.pipeline.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_function.pipeline]
}
