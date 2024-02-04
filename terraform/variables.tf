variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "lambda_code_path" {
  description = "Lambda code directory path"
  type        = string
  default     = "/path/to/lambda/code"
}
