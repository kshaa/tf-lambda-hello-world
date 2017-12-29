# AWS Lambda hello world
A test project to research Terraform & AWS Lambda w/ Python.

## hello.py
Has two entrypoints:

1. Main entrypoint, when launched as a standalone script
The hello.py reads an environtment variable 'foo' and prints it out.
If it ísn't defined, an exception message is printed.

2. AWS Lambda entrypoint, when imported and executed by AWS Lambda
Pretty prints event and context objects, and continues as per main entrypoint

#### Execution
~~~~
export foo="Hello world"
python3 code/hello.py
~~~~

## Terraform deployment
Manages and connects such inventory:
* AWS as the provider (London region)
* AWS Lambda function w/ environment variable 'foo'
* IAM role for the function
* Default IAM lambda trust relationship policy
* Policy extension to allow logging to AWS CloudWatch
* Deployment archive of the python code

#### Execution
First set up [AWS cli][1] & [access credentials][2]
~~~~
terraform init
terraform plan # Review resources to be managed
terraform apply # Apply changes
~~~~

[1]: http://docs.aws.amazon.com/cli/latest/userguide/installing.html "AWS CLI installation guide"
[2]: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html "AWS CLI configuration guide"
