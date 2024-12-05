import sys
import os
# Add the `terraform` directory to PYTHONPATH dynamically
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../")))
import lambda_function  # Import the Lambda function directly
def test_lambda_handler():
    # Mock event and context
    mock_event = {"key": "value"}
    mock_context = {}
    # Call the Lambda handler
    response = lambda_function.lambda_handler(mock_event, mock_context)
    # Assert the response
    assert response["statusCode"] == 200
    assert response["body"] == "Hello from Lambda! this is bhupal"  