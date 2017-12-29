#!/usr/local/bin/python3
import os
from pprint import pprint

hello_key = 'foo'

def main():
    try:
        hello = os.environ[hello_key]
        print(hello)
    except KeyError:
        print("Missing \'{}\' environment variable".format(hello_key))

# Entrypoints
## Lambda invocation
def lamda_handler(event, context):
    pprint(event)
    pprint(context)
    main()

## Standalone invocation
if __name__ == "__main__":
    main()
