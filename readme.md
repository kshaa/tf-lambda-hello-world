# AWS Lambda hello world
A test project to research Terraform & AWS Lambda w/ Python.

## Script hello.py
#### Functionality
1. Main entrypoint (main), when launched as a standalone script:

The hello.py reads an environtment variable 'foo' and prints it out.
If it ísn't defined, an exception message is printed.

2. AWS Lambda entrypoint (lambda\_handler), when imported and executed by AWS Lambda:

Pretty prints Lambda event and context objects, and continues as per main entrypoint

#### Execution
~~~~
export foo="Hello world"
python3 code/hello.py
~~~~

## Terraform deployment
#### Managed inventory
* AWS as the provider (London region)
* AWS Lambda function w/ environment variable 'foo'
* IAM role for the function
* Default IAM lambda trust relationship policy
* Policy extension to allow logging to AWS CloudWatch
* Deployment archive of the python code

#### Deployment
First set up [AWS cli][1] & [access credentials][2]
~~~~
terraform init
terraform plan # Review resources to be managed
terraform apply # Apply changes
~~~~
[1]: http://docs.aws.amazon.com/cli/latest/userguide/installing.html "AWS CLI installation guide"
[2]: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html "AWS CLI configuration guide"

#### Invocation
~~~~
aws lambda invoke \
    --invocation-type RequestResponse \
    --function-name hello_lambda \
    --region eu-west-2 \
    --log-type Tail
~~~~

Log result will be encoded in base64, see [documentation][3] for how to decode it. Or check the result in [CloudWatch console][4] logs.

[3]: http://docs.aws.amazon.com/lambda/latest/dg/with-userapp-walkthrough-custom-events-invoke.html "Lambda invocation documentation"
[4]: https://console.aws.amazon.com/cloudwatch/ "Cloudwatch console"
