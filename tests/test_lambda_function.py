import pytest
from lambda_function import lambda_handler

def test_handler():
    event = {}
    context ={}
    response = lambda_handler(event, context)
    assert response['statusCode']== 200
    assert response['body']== 'Hello from Lambda! this is bhupal'