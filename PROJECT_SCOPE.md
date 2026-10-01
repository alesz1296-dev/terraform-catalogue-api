# Project Scope

## Project Name

Terraform Catalogue API

## Purpose

Build a serverless API that stores and returns Terraform module metadata.

This API will eventually support the Terraform Catalogue static website by replacing hardcoded module data with data returned from AWS.

## Problem Statement

The static website from Project I: Terraform Catalogue web displays Terraform module information directly in HTML. That is simple and cheap, but it does not teach backend architecture, data storage, API design, IAM service permissions, or observability.

Project II introduces a dynamic backend while keeping the system small enough to reason about.

## First Version Scope

Version 1 will provide read-only access to module data.

Initial endpoints:

```text
GET /modules
GET /modules/{id}
```

Initial data model:

```json
{
  "module_id": "s3-static-site",
  "name": "S3 Static Site",
  "category": "Storage",
  "difficulty": "Beginner",
  "services": ["S3", "CloudFront", "IAM"],
  "description": "Private S3 bucket with CloudFront delivery.",
  "status": "Published"
}
```

## In Scope

- API Gateway HTTP API
- Lambda function
- DynamoDB table
- IAM role and least-privilege policy for Lambda
- CloudWatch logs
- Terraform-managed infrastructure
- Terraform outputs for API endpoint and table name
- Basic seed data approach
- README and design documentation

## Out Of Scope For Version 1

- Authentication
- Write endpoints
- Custom domain
- Route 53
- API Gateway REST API
- Cognito
- CI/CD pipeline
- Frontend integration with Terraform Catalogue static web
- Advanced monitoring and alarms
- DynamoDB global secondary indexes

These may be added in later phases after the first working API is understood.

## Learning Goals

- How API Gateway invokes Lambda
- How Lambda reads from DynamoDB
- How IAM allows Lambda to access DynamoDB
- How CloudWatch captures Lambda logs
- Why HTTP API is chosen over REST API for this use case
- Why DynamoDB is a good fit for simple catalogue metadata
- Why read-only endpoints are implemented before write endpoints
- How Terraform manages serverless infrastructure

## Success Criteria

The first milestone is complete when:

- Terraform creates the API infrastructure successfully.
- `GET /modules` returns a JSON list of modules.
- `GET /modules/{id}` returns one module or a clear `404`.
- Lambda logs can be inspected in CloudWatch.
- DynamoDB contains seed module records.
- Terraform outputs the API base URL.
- The README explains deployment, testing, and cleanup.
