variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "s3_input_bucket" {
  description = "S3 input bucket for raw CSV"
  type        = string
}

variable "s3_output_bucket" {
  description = "S3 output bucket for transformed data"
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to lambda deployment ZIP"
  type        = string
  default     = "./Lambda_Function/lambda.zip"
}
