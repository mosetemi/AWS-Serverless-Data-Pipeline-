output "lambda_function_arn" {
  description = "Deployed lambda function ARN"
  value       = aws_lambda_function.pipeline.arn
}

output "input_bucket_name" {
  value = aws_s3_bucket.input.bucket
}

output "output_bucket_name" {
  value = aws_s3_bucket.output.bucket
}