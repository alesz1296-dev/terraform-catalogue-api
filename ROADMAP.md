# Roadmap

## Phase 0: Design And Planning

Goal: understand the architecture before writing Terraform or Lambda code.

Deliverables:

- Project scope document
- Initial roadmap
- Design decision log
- Cost-aware architecture notes

Learning checkpoints:

- Explain static website vs dynamic backend
- Explain API Gateway, Lambda, and DynamoDB roles
- Explain the request path from browser to database

## Phase 1: Local API Shape

Goal: define the API contract before deploying cloud infrastructure.

Tasks:

- Choose response format
- Define module metadata fields
- Decide error response shape
- Sketch `GET /modules`
- Sketch `GET /modules/{id}`

Deliverables:

- Example JSON responses
- Initial Lambda handler design

Learning checkpoints:

- Explain HTTP status codes used by the API
- Explain why API shape should be designed before infrastructure

## Phase 2: Terraform Foundation

Goal: create the serverless infrastructure skeleton.

Terraform resources likely include:

- AWS provider configuration
- DynamoDB table
- Lambda IAM role
- Lambda IAM policy for DynamoDB read access
- Lambda function
- API Gateway HTTP API
- API Gateway Lambda integration
- API Gateway routes
- Lambda permission for API Gateway
- CloudWatch log group

Deliverables:

- `infra/` Terraform structure
- `terraform validate`
- `terraform plan`
- First successful `terraform apply`

Learning checkpoints:

- Explain which resources are infrastructure
- Explain which resources are permissions
- Explain why Lambda needs an execution role

Current status:

- DynamoDB table deployed.
- CloudWatch log group deployed with short retention.
- Lambda IAM role deployed.
- Lambda CloudWatch logging permission deployed.
- Lambda DynamoDB read-only policy deployed.
- Lambda function deployment started with a zip package.
- Direct Lambda invocation reaches the function, but currently returns `FunctionError: Unhandled`.

Next troubleshooting step:

- Inspect the Lambda response payload and CloudWatch logs to identify the handler/runtime error before adding API Gateway.

## Phase 3: Lambda And DynamoDB

Goal: make Lambda return real data from DynamoDB.

Tasks:

- Write Lambda handler
- Read all modules from DynamoDB
- Read one module by ID
- Return JSON responses
- Handle not-found cases
- Add useful structured logs

Deliverables:

- Working Lambda function
- Seed data in DynamoDB
- Successful API tests

Learning checkpoints:

- Explain DynamoDB partition key
- Explain when scan is acceptable and when it is not
- Explain Lambda environment variables

## Phase 4: API Testing

Goal: test the API as an external client would use it.

Tasks:

- Test `GET /modules`
- Test `GET /modules/{id}`
- Test unknown module ID
- Inspect CloudWatch logs
- Verify IAM permissions are not broader than needed

Deliverables:

- Test commands in README
- Example successful responses
- Example error response

Learning checkpoints:

- Explain API Gateway route matching
- Explain Lambda proxy-style request and response
- Explain how logs help debug serverless systems

## Phase 5: Cost And Operations

Goal: make the project safer to leave running.

Tasks:

- Add CloudWatch log retention
- Confirm DynamoDB billing mode
- Add cost notes to README
- Add cleanup instructions
- Add AWS Budget reminder

Deliverables:

- Cost-aware README section
- Clear cleanup procedure

Learning checkpoints:

- Explain which services charge per request
- Explain why logs can become a surprise cost
- Explain why a low-traffic serverless API is cheap

## Phase 6: Optional Enhancements

These are intentionally deferred.

Possible future additions:

- Frontend integration with Project 1
- CORS configuration for the static website domain
- GitHub Actions deployment
- `POST /modules`
- `PUT /modules/{id}`
- `DELETE /modules/{id}`
- Authentication for write endpoints
- CloudWatch alarms
- Custom domain
- OpenAPI documentation

Learning checkpoint:

- Explain which enhancement should come next and why.
