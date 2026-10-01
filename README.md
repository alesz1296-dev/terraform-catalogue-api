# Terraform Catalogue API

A serverless AWS API for storing and serving Terraform module metadata.

This is Project 2 in the AWS Cloud/DevOps learning roadmap. It builds on the static Terraform Catalogue website by adding a backend API powered by API Gateway, Lambda, and DynamoDB.

## Goal

Build a small, production-minded serverless API that can return Terraform module information such as name, category, difficulty, AWS services used, and description.

The first version will be read-only:

- `GET /modules`
- `GET /modules/{id}`

Write operations, authentication, custom domains, and CI/CD will be added only after the core serverless architecture is understood.

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

This project is designed to stay low-cost for learning usage by using serverless, pay-per-use services:

- API Gateway HTTP API
- Lambda
- DynamoDB on-demand
- CloudWatch Logs with short retention

Expected learning cost should be close to zero or well under one dollar per month at low traffic.
