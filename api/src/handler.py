import json
import os

import boto3


dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def json_response(status_code, payload):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(payload)
    }


def error_response(status_code, code, message):
    return json_response(status_code, {
        "error": {
            "code": code,
            "message": message
        }
    })


def list_modules():
    response = table.scan()
    modules = response.get("Items", [])

    return json_response(200, {
        "count": len(modules),
        "modules": modules
    })


def get_module(module_id):
    response = table.get_item(
        Key={
            "module_id": module_id
        }
    )

    module = response.get("Item")

    if module is None:
        return error_response(
            404,
            "MODULE_NOT_FOUND",
            "Module not found."
        )

    return json_response(200, {
        "module": module
    })


def handler(event, context):
    method = event.get("requestContext", {}).get("http", {}).get("method")
    path = event.get("rawPath")
    path_parameters = event.get("pathParameters") or {}
    module_id = path_parameters.get("id")

    if method == "GET" and path == "/modules":
        return list_modules()

    if method == "GET" and module_id:
        return get_module(module_id)

    return error_response(
        404,
        "ROUTE_NOT_FOUND",
        "Route not found."
    )