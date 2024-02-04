// Define the provider
provider "aws" {
    region = var.aws_region
}

// Create an SNS topic for receiving text messages
resource "aws_sns_topic" "text_message_topic" {
  name = "text_message_topic"
}

// Create an S3 bucket to store Lambda function code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-bucket" // Replace with your desired bucket name
  acl    = "private"
}

// Create a Lambda function to process text messages
resource "aws_lambda_function" "text_message_processor" {
    function_name    = "text_message_processor"
    runtime          = "nodejs14.x" // Replace with your desired runtime
    handler          = "index.handler"
    timeout          = 10 // Replace with your desired timeout
    role             = aws_iam_role.lambda_role.arn // Add the missing "role" attribute
    // Attach the S3 bucket as the source code for the Lambda function
    source_code_hash = filebase64sha256(var.lambda_code_path) // Replace with the variable for the Lambda function code path
}

// Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// Attach the necessary policies to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

// Grant the Lambda function permission to publish to the SNS topic
resource "aws_sns_topic_policy" "text_message_topic_policy" {
  arn    = aws_sns_topic.text_message_topic.arn
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "${aws_sns_topic.text_message_topic.arn}"
    }
  ]
}
EOF
}
// Define the provider
provider "aws" {
  region = "us-west-2" // Replace with your desired region
}

// Create an SNS topic for receiving text messages
resource "aws_sns_topic" "text_messages" {
  name = "text-messages-topic"
}

// Create an S3 bucket to store Lambda function code
resource "aws_s3_bucket" "lambda_code" {
  bucket = "lambda-code-bucket" // Replace with your desired bucket name
  acl    = "private"
}

// Create a Lambda function to process and respond to text messages
resource "aws_lambda_function" "text_message_processor" {
    function_name = "text-message-processor"
    runtime       = "nodejs14.x" // Replace with your desired runtime
    handler       = "index.handler"
    role          = aws_iam_role.lambda_role.arn // Add the missing "role" attribute
}

// Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// Attach the necessary policies to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

// Grant the Lambda function permission to publish to the SNS topic
resource "aws_sns_topic_policy" "text_message_topic_policy" {
  arn    = aws_sns_topic.text_message_topic.arn
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "${aws_sns_topic.text_message_topic.arn}"
    }
  ]
}
EOF
}
// Define the provider
provider "aws" {
  region = "us-west-2" // Replace with your desired region
}

// Create an SNS topic for receiving text messages
resource "aws_sns_topic" "text_messages" {
  name = "text-messages-topic"
}

// Create an S3 bucket to store Lambda function code
resource "aws_s3_bucket" "lambda_code" {
  bucket = "lambda-code-bucket" // Replace with your desired bucket name
  acl    = "private"
}

// Create a Lambda function to process and respond to text messages
resource "aws_lambda_function" "text_message_processor" {
    function_name    = "text-message-processor"
    runtime          = "nodejs14.x" // Replace with your desired runtime
    handler          = "index.handler"
    timeout          = 10 // Replace with your desired timeout
    role             = aws_iam_role.lambda_role.arn // Add the missing "role" attribute

    // Attach the S3 bucket as a source for the Lambda function code
    source_code_hash = filebase64sha256("path/to/lambda/code.zip") // Replace with the path to your Lambda function code zip file
    s3_bucket        = aws_s3_bucket.lambda_code.bucket
    s3_key           = "lambda-code.zip" // Replace with the name of your Lambda function code zip file

    // Configure the Lambda function to trigger on incoming text messages
    environment {
        variables = {
            SNS_TOPIC_ARN = aws_sns_topic.text_messages.arn
        }
    }

    // Grant necessary permissions to the Lambda function
    // (e.g., access to S3 bucket, SNS topic, etc.)
    // ...

    // Add any other necessary configuration for the Lambda function
    // ...
}

// Configure the SNS topic to trigger the Lambda function on incoming text messages
resource "aws_sns_topic_subscription" "lambda_trigger" {
  topic_arn = aws_sns_topic.text_messages.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.text_message_processor.arn
}
