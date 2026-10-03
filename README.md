# Terraform Catalogue API

A serverless AWS API for storing and serving Terraform module metadata.

This project extends the Terraform Catalogue static website with a backend API powered by API Gateway, Lambda, and DynamoDB.

Current v1 status: the read-only API is deployed and returning module data from DynamoDB.

## Goal

Build a small, production-minded serverless API that returns structured Terraform module information, including name, category, difficulty, AWS services used, service features, use cases, and description.

The first version will be read-only:

- `GET /modules`
- `GET /modules/{id}`

Write operations, authentication, custom domains, and CI/CD are planned as later enhancements after the read-only API is stable.

## Architecture

```text
Client or browser
  -> API Gateway HTTP API
  -> Lambda
  -> DynamoDB
  -> CloudWatch Logs
```

## Current Endpoint

```text
https://0bbo9rq0qh.execute-api.us-east-1.amazonaws.com
```

## Test Commands

List modules:

```powershell
curl.exe -i https://0bbo9rq0qh.execute-api.us-east-1.amazonaws.com/modules
```

Expected result:

```text
HTTP/1.1 200 OK
```

Response shape:

```json
{
  "count": 1,
  "modules": []
}
```

Get one module:

```powershell
curl.exe -i https://0bbo9rq0qh.execute-api.us-east-1.amazonaws.com/modules/s3-static-site
```

Expected result:

```text
HTTP/1.1 200 OK
```

Response shape:

```json
{
  "module": {}
}
```

Unknown module:

```powershell
curl.exe -i https://0bbo9rq0qh.execute-api.us-east-1.amazonaws.com/modules/unknown-module
```

Expected result:

```text
HTTP/1.1 404 Not Found
```

## Documentation

- [PROJECT_SCOPE.md](PROJECT_SCOPE.md): project purpose, boundaries, and design scope
- [ROADMAP.md](ROADMAP.md): phased implementation plan
- [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md): architecture decisions and trade-offs

## Cost Posture

This project is designed to stay low-cost at portfolio/demo scale by using serverless, pay-per-use services:

- API Gateway HTTP API
- Lambda
- DynamoDB on-demand
- CloudWatch Logs with short retention

Expected cost should be close to zero or well under one dollar per month at low traffic.

## Local Files Not Committed

The project intentionally excludes local Terraform state, generated Lambda zip packages, local API test payloads, and manual seed files from Git.

Examples:

- `infra/.terraform/`
- `infra/build/`
- `infra/terraform.tfstate`
- `infra/event.json`
- `infra/response.json`
- `infra/seed-item.json`
- `infra/key.json`
