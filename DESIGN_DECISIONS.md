# Design Decisions

This file records architecture choices, trade-offs, and reasoning for the Terraform Catalogue API project.

## Decision 001: Use API Gateway HTTP API

Date: 2026-10-01

Status: Proposed

## Context

The API needs to expose simple HTTP endpoints backed by Lambda.

AWS offers API Gateway HTTP APIs and REST APIs. REST APIs have more advanced features, but HTTP APIs are simpler, lower-cost, and sufficient for basic Lambda-backed endpoints.

## Decision

Use API Gateway HTTP API for the first version.

## Reasoning

HTTP API is a good fit because the first version only needs:

- `GET /modules`
- `GET /modules/{id}`
- Lambda integration
- Basic public read access

## Trade-Offs

Benefits:

- Simpler to configure
- Lower cost than REST API
- Good fit for basic serverless APIs
- Enough for the first project milestone

Costs:

- Fewer advanced API Gateway features than REST API
- May need to revisit if future requirements become more complex

## Decision 002: Use Lambda For Backend Logic

Date: 2026-10-01

Status: Proposed

## Context

The backend logic is small and request-driven. It does not need a long-running server.

## Decision

Use AWS Lambda instead of ECS, EC2, or App Runner for the first backend implementation.

## Reasoning

Lambda keeps the API serverless and focused:

- No server management
- No container orchestration
- Scales automatically
- Charges mainly when invoked
- Pairs naturally with API Gateway

## Trade-Offs

Benefits:

- Low operational overhead
- Low cost at small scale
- Strong fit for short request/response workloads

Costs:

- Cold starts are possible
- Stateless execution model
- Package and runtime limits
- Not ideal for long-running tasks

## Decision 003: Use DynamoDB On-Demand

Date: 2026-10-01

Status: Proposed

## Context

The API stores simple module metadata and will receive low, unpredictable learning traffic.

## Decision

Use DynamoDB with on-demand billing for version 1.

## Reasoning

DynamoDB fits simple metadata lookup and avoids database server management.

On-demand billing avoids capacity planning while traffic is tiny and unpredictable.

## Trade-Offs

Benefits:

- Serverless database
- No capacity planning
- Low cost for small usage
- Simple key-value/document access

Costs:

- Requires access-pattern thinking
- No SQL joins
- Scans do not scale well for large tables
- Query design may need refactoring later

## Decision 004: Start With Read-Only Endpoints

Date: 2026-10-01

Status: Proposed

## Context

Full CRUD would require write permissions and authentication decisions.

## Decision

Start with read-only endpoints:

```text
GET /modules
GET /modules/{id}
```

## Reasoning

Read-only endpoints keep the first version focused on core serverless architecture:

- API Gateway routing
- Lambda integration
- DynamoDB reads
- IAM read permissions
- CloudWatch logs

## Trade-Offs

Benefits:

- Simpler IAM
- No authentication required for public module metadata
- Easier first milestone
- Lower risk

Costs:

- No admin workflow yet
- Seed data must be loaded separately
- Write endpoints are deferred

## Decision 005: Use Short CloudWatch Log Retention

Date: 2026-10-01

Status: Proposed

## Context

CloudWatch Logs are useful for debugging but can become a hidden cost if logs are noisy or retained forever.

## Decision

Configure short log retention for Lambda logs, such as 7 or 14 days.

## Reasoning

Short retention keeps logs useful for learning and troubleshooting while limiting long-term cost.

## Trade-Offs

Benefits:

- Keeps observability
- Reduces forgotten log storage
- Encourages cost-aware operations

Costs:

- Older logs are not retained
- Long-term historical debugging is limited

## Decision 006: Package Lambda Code As A Zip

Date: 2026-10-02

Status: Accepted

## Context

AWS Lambda does not run code directly from the local development folder. The function code must be uploaded to AWS as a deployment package.

For the first implementation, the handler is a simple Python file:

```text
api/src/handler.py
```

## Decision

Package the Lambda code as a `.zip` file and deploy it through Terraform using `aws_lambda_function`.

The zip package should contain `handler.py` at the root:

```text
lambda.zip
  handler.py
```

The Lambda handler setting is:

```text
handler.handler
```

This means:

```text
file: handler.py
function: handler
```

## Reasoning

This keeps the first Lambda deployment simple and focused:

- No external dependencies are required yet.
- The deployment package is small.
- Terraform can upload the zip to Lambda.
- The handler path stays easy to understand.

## Trade-Offs

Benefits:

- Simple first deployment model.
- Easy to inspect what code is being deployed.
- Good fit for a single-file handler.

Costs:

- The zip must be recreated when handler code changes.
- Manual packaging can cause path mistakes.
- A future CI/CD pipeline should automate packaging.

## Follow-Up

Later, replace manual zip creation with one of these approaches:

- Terraform `archive_file` for simple local packaging.
- GitHub Actions build artifact for a more production-like deployment pipeline.
