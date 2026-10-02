# Terraform Catalogue API

A serverless AWS API for storing and serving Terraform module metadata.

This project extends the Terraform Catalogue static website with a backend API powered by API Gateway, Lambda, and DynamoDB.

## Goal

Build a small, production-minded serverless API that returns structured Terraform module information, including name, category, difficulty, AWS services used, service features, use cases, and description.

The first version will be read-only:

- `GET /modules`
- `GET /modules/{id}`

Write operations, authentication, custom domains, and CI/CD are planned as later enhancements after the read-only API is stable.

## Planned Architecture

```text
Client or browser
  -> API Gateway HTTP API
  -> Lambda
  -> DynamoDB
  -> CloudWatch Logs
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
