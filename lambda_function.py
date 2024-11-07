# lambda_function.py

import json

def lambda_handler(event, context):
    print("Event:", event)
    
    response = {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Hello from Lambda! this is bhupal",
            "input": event
        })
    }
    
    return response