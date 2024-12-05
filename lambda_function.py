# lambda_function.py

import json

def lambda_handler(event, context):
    print("Event:", event)
    
    response = {
        "statusCode": 200,
        "body": "Hello from Lambda! this is bhupal"
    }
    
    return response