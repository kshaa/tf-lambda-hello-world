provider "aws" {
    region = "eu-west-2"
}

# Create deployment package
data "archive_file" "hello_zip" {
    type        = "zip"
    source_dir  = "code"
    output_path = "hello.zip"
}

# Logging policy attachment
data "aws_iam_policy_document" "logging" {
    statement {
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams"
        ]

        resources = [
            "arn:aws:logs:*:*:*"
        ]
    }
}

resource "aws_iam_policy" "logging" {
    name = "allow_logging"
    description = "Policy to allow logging to CloudWatch"
    policy = "${data.aws_iam_policy_document.logging.json}"
}

# Default lambda policy
data "aws_iam_policy_document" "lambda" {
    statement {
        sid = "1"

        actions = [
            "sts:AssumeRole"
        ]

        principals = {
            type = "Service"
            identifiers = [
                "lambda.amazonaws.com"
            ]   
        }
    }
}

# Hello world app role
resource "aws_iam_role" "hello_role" {
  name = "hello_role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda.json}"
}

# Attach logging to hello world
resource "aws_iam_role_policy_attachment" "attach-logging" {
    role       = "${aws_iam_role.hello_role.name}"
    policy_arn = "${aws_iam_policy.logging.arn}"
}

# Generate hello world lambda function
resource "aws_lambda_function" "hello_lambda" {
  filename         = "hello.zip"
  function_name    = "hello_lambda"
  role             = "${aws_iam_role.hello_role.arn}"
  handler          = "hello.lamda_handler"
  source_code_hash = "${data.archive_file.hello_zip.output_base64sha256}"
  runtime          = "python3.6"

  environment {
    variables = {
      foo = "Hello world"
    }
  }
}

